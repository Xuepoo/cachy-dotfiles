-- ~/.config/hypr/colors-template.lua
return {
    active_border = {
        colors = { "rgba({{colors.primary.default.hex_stripped}}ff)", "rgba({{colors.primary_container.default.hex_stripped}}8e)" },
        angle = 30,
    },
    inactive_border = "rgba({{colors.surface_variant.default.hex_stripped}}aa)",
}
