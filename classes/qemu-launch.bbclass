# qemu-launch.bbclass
# Generates a QEMU launch script in DEPLOY_DIR_IMAGE during image build.
# The script uses relative paths so it's portable with its artifacts.

python generate_qemu_launch_script() {
    import os

    deploy_dir = d.getVar('DEPLOY_DIR_IMAGE')
    if not deploy_dir:
        bb.note('DEPLOY_DIR_IMAGE not set, skipping QEMU script generation')
        return

    # Kernel — use first type from KERNEL_IMAGETYPES
    kernel_types = (d.getVar('KERNEL_IMAGETYPES') or 'Image').split()
    kernel = kernel_types[0]

    # Rootfs — use IMAGE_LINK_NAME for the unversioned symlink name
    link_name = d.getVar('IMAGE_LINK_NAME')
    rootfs = '{}.cpio.gz'.format(link_name) if link_name else 'rootfs.cpio.gz'

    # Model disk name
    machine = d.getVar('MACHINE') or 'qemuarm64'
    model_image = 'tinyai-model-image-{}.ext4'.format(machine)

    # Console — derive from SERIAL_CONSOLES if set
    serial_consoles = (d.getVar('SERIAL_CONSOLES') or '').split()
    console = 'ttyAMA0'
    for entry in serial_consoles:
        parts = entry.split(';')
        if len(parts) == 2:
            console = parts[1]
            break

    # Locate the template relative to the layer root.
    # NOTE: d.getVar('FILE') is the recipe path, not the bbclass path.
    # Recipes live at <layer>/recipes-<category>/<pn>/<recipe>.bb,
    # so we go up 2 levels to reach the layer root.
    recipe_dir = os.path.dirname(d.getVar('FILE'))
    template_path = os.path.join(recipe_dir, '..', '..', 'files', 'qemu-boot.sh.in')
    template_path = os.path.normpath(template_path)

    if not os.path.exists(template_path):
        bb.fatal('QEMU launch script template not found: {}'.format(template_path))

    with open(template_path, 'r') as f:
        script = f.read()

    # Substitute placeholders
    script = script.replace('@MACHINE@', machine)
    script = script.replace('@KERNEL@', kernel)
    script = script.replace('@ROOTFS@', rootfs)
    script = script.replace('@MODEL_IMAGE@', model_image)
    script = script.replace('@CONSOLE@', console)

    script_path = os.path.join(deploy_dir, 'qemu-boot.sh')
    with open(script_path, 'w') as f:
        f.write(script)
    os.chmod(script_path, 0o755)
    bb.note('Generated QEMU launch script: {}'.format(script_path))
}

IMAGE_POSTPROCESS_COMMAND += "generate_qemu_launch_script; "
