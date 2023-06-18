# Project name, programming language and version
project (
    'ens-tui-shell',
    'c', 'vala',
    version: '0.1.0',
    meson_version: '>=0.57.0'
)

# Translation module
i18n = import ('i18n')

# Project arguments
add_project_arguments (
    '-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name ()),
    '-DG_LOG_DOMAIN="Ensembles"',
    language: 'c'
)

# Listing dependencies
dependencies = [
    dependency ('glib-2.0'),
    dependency ('gobject-2.0'),
    dependency ('libsoup-3.0'),
    dependency ('json-glib-1.0'),
    meson.get_compiler ('c').find_library ('m', required : true),
]

subdir ('src')

# Define library
libens_tui_shell = static_library (
    meson.project_name () + '-' + meson.project_version().split('.')[0],
    sources,
    dependencies: dependencies,
    install: true,
    install_dir: [true, true, true]
)

subdir ('po')

ens_tui_shell_dep = declare_dependency (
    dependencies: dependencies,
    include_directories: include_directories('.'),
    link_with: libens_tui_shell
)
