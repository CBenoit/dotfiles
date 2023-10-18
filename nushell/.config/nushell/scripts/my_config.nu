## Startup

$env.config.show_banner = false

## Commands

$env.config.ls.clickable_links = false
$env.config.rm.always_trash = true

## History

$env.config.history.file_format = sqlite

## Table

$env.config.table.mode = compact
$env.config.table.header_on_separator = true

## Hooks

$env.config.hooks.command_not_found = { |cmd_name|
    if (which pkgfile | is-empty) {
        return null
    }

    print $"Looking for Arch packages shipping '($cmd_name)'…"
    let pkgs = pkgfile --binaries --verbose $cmd_name
    if ($pkgs | is-empty) {
        return null
    }

    $"(ansi $env.config.color_config.shape_external)($cmd_name)(ansi reset) may be found in the following packages:\n($pkgs)"
}
