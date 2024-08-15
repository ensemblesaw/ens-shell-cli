# Project name, programming language and version
project (
    'ens-shell-cli',
    'c', 'vala',
    version: '0.1.0',
    meson_version: '>=0.57.0'
)

# Translation module
i18n = import ('i18n')

# Package Config
pkg = import('pkgconfig')

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
    meson.get_compiler ('c').find_library ('m', required : true),
]

subdir ('src')

# Define library
libens_shell_cli = static_library (
    meson.project_name () + '-' + meson.project_version().split('.')[0],
    sources,
    dependencies: dependencies,
    install: true
)

subdir ('po')

ens_shell_cli_dep = declare_dependency (
    dependencies: dependencies,
    include_directories: include_directories('.'),
    link_with: libens_shell_cli
)

ens_shell_cli_pc = pkg.generate(
    libens_shell_cli
)
