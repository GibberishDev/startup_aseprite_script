template_ray_dark_path = "startup_templates/shrray_tmplt_dark.png"
template_ray_light_path = "startup_templates/shrray_tmplt_light.png"
template_smol_dark_path = "startup_templates/dark_smol.png"
template_smol_light_path = "startup_templates/light_smol.png"
template_large_dark_path = "startup_templates/dark_large.png"
template_large_light_path = "startup_templates/light_large.png"

function get_scripts_foulder_path()
  local fullpath = debug.getinfo(1,"S").source:sub(2)
  local fullpath_rev = fullpath:reverse()
  while fullpath_rev:sub(1, 1) ~= "\\" do
    fullpath_rev = fullpath_rev:sub(2)
  end
  return(fullpath_rev:reverse())
end

scripts_path = get_scripts_foulder_path()


function __main__()
  dlg = Dialog("Create new sprite")
  dlg:label{ id="dlg_labl_1", text="Template:"}
  dlg:combobox{ id="template",
                option="Default - dark",
                options={"Default - dark", "Default - light", "Default large(1024x1024) - dark", "Default large(1024x1024) - light", "Shrink ray challenge - dark", "Shrink ray challenge - light"}
              }
  dlg:newrow()
  dlg:button{id="load",text="Load selected template"}
  dlg:button{id="cancel",text="Cancel"}
  dlg:show()
  data = dlg.data
  if data.load then
    spr = Sprite(1, 1)
    if data.template == "Default - dark" then change_selected_template(0)
    elseif data.template == "Default - light" then change_selected_template(1)
    elseif data.template == "Default large(1024x1024) - dark" then change_selected_template(2)
    elseif data.template == "Default large(1024x1024) - light" then change_selected_template(3)
    elseif data.template == "Shrink ray challenge - dark" then change_selected_template(4)
    elseif data.template == "Shrink ray challenge - light" then change_selected_template(5)
    else print("ERROR - Nonexistent template value")
    end
  end
end

function change_selected_template(id)
  if id == 0 then
    create_new_default_sprite(false, true)
  elseif id == 1 then
    create_new_default_sprite(false, false)
  elseif id == 2 then
    create_new_default_sprite(true, true)
  elseif id == 3 then
    create_new_default_sprite(true, false)
  elseif id == 4 then
    create_new_shrnk_ray_sprite(true)
  elseif id == 5 then
    create_new_shrnk_ray_sprite(false)
  end
end

function create_new_shrnk_ray_sprite(dark)
  spr.width = 256
  spr.height = 128
  bg = spr:newLayer()
  bg.name = "bg"
  spr:deleteLayer("Layer 1")
  if dark == true then
    img_template_ray_dark = Image{fromFile = scripts_path .. template_ray_dark_path}
    local cel = spr:newCel(bg, 1, img_template_ray_dark, Point(0,0))
  else
    img_template_ray_light = Image{fromFile = scripts_path .. template_ray_light_path}
    local cel = spr:newCel(bg, 1, img_template_ray_light, Point(0,0))
  end
end

function create_new_default_sprite(large, dark)
  bg = spr:newLayer()
  bg.name = "bg"
  spr:deleteLayer("Layer 1")
  if large == true then
    spr.width = 1024
    spr.height = 1024
    if dark == true then
      img_template_large_dark = Image{fromFile = scripts_path .. template_large_dark_path}
      local cel = spr:newCel(bg, 1, img_template_large_dark, Point(0,0))
    else
      img_template_large_light = Image{fromFile = scripts_path .. template_large_light_path}
      local cel = spr:newCel(bg, 1, img_template_large_light, Point(0,0))
    end
  else
    spr.width = 256
    spr.height = 256
    if dark == true then
      img_template_smol_dark = Image{fromFile = scripts_path .. template_smol_dark_path}
      local cel = spr:newCel(bg, 1, img_template_smol_dark, Point(0,0))
    else
      img_template_smol_light = Image{fromFile = scripts_path .. template_smol_light_path}
      local cel = spr:newCel(bg, 1, img_template_smol_light, Point(0,0))
    end
  end
end

__main__()
