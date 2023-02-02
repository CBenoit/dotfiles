mut my_config = $env.config

$my_config.completions.algorithm = "fuzzy"
$my_config.show_banner = false

let-env config = $my_config
