# ~/.config/fish/colors-template.fish
# Fish syntax highlighting colors compiled by Matugen

set -U fish_color_normal '{{colors.on_surface.default.hex}}'
set -U fish_color_command '{{colors.primary.default.hex}}' --bold
set -U fish_color_param '{{colors.secondary.default.hex}}'
set -U fish_color_keyword '{{colors.tertiary.default.hex}}' --bold
set -U fish_color_quote '{{colors.tertiary.default.hex}}'
set -U fish_color_redirection '{{colors.primary.default.hex}}'
set -U fish_color_end '{{colors.secondary.default.hex}}'
set -U fish_color_error '{{colors.error.default.hex}}' --bold
set -U fish_color_comment '{{colors.on_surface_variant.default.hex}}'
set -U fish_color_selection --background='{{colors.surface_container_high.default.hex}}'
set -U fish_color_search_match --background='{{colors.surface_container_high.default.hex}}'
set -U fish_color_operator '{{colors.primary.default.hex}}'
set -U fish_color_escape '{{colors.tertiary.default.hex}}'
set -U fish_color_autosuggestion '{{colors.outline_variant.default.hex}}'

# Fish pager colors
set -U fish_pager_color_prefix '{{colors.primary.default.hex}}' --bold
set -U fish_pager_color_completion '{{colors.on_surface.default.hex}}'
set -U fish_pager_color_description '{{colors.on_surface_variant.default.hex}}'
set -U fish_pager_color_progress '{{colors.secondary.default.hex}}'
