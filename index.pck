GDPC                @                                                                         \   res://.godot/exported/133200997/export-0fc9df56efb8dd4291a188b7dbd20cdf-Stamina_Bottom.res  P5      �      JP�0�e�Ш)G�F�    X   res://.godot/exported/133200997/export-29e04b2a507ad1490658bea649d50e6c-Stamina_Top.res �;      �      �q޿cw��Z�e)`    X   res://.godot/exported/133200997/export-a760568f5c084056965d55de6439dc53-primary_3d.scn  @
      +      �����㾩;It�B�    ,   res://.godot/global_script_class_cache.cfg  PD             ��Р�8���8~$}P�       res://.godot/uid_cache.bin  pD      l       ���2%9:_[l����       res://Character.gd          R      y�zޓ���2�k�!�Z       res://Primary3D.gd  `      �      ����L�3D�G�Vv�2        res://Stamina_Bottom.tres.remap pC      k       
�E��?9��Rb�.       res://Stamina_Top.tres.remap�C      h       �o��#!��8���       res://UI.gd `B      �       P�6�y��MQ�����       res://primary_3d.tscn.remap  C      g       vűj��С�^(F��#t       res://project.binary�D      �      ��}�޹碸I����    �����t�extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var speed = 6
var jump_speed = 5
var ResetSpeed = false
var ready_to_interact = false
var door_open = false
var mouse_sensitivity = 0.002

#signal 
#signal 
signal Sprinting
signal Walking

func _ready():
	get_parent().get_node("UI").connect("StaminaEmpty", Reset)

func _physics_process(delta):
	if $Camera3D/RayCast3D.get_collider() == null:
		ready_to_interact = false
		get_parent().get_node("UI").get_node("E_To_Interact_Label").text = ""
	else:
		if $Camera3D/RayCast3D.get_collider().name == "DoorControls_InteractArea":
			ready_to_interact = true
			get_parent().get_node("UI").get_node("E_To_Interact_Label").text = "E To Interact"
			if Input.is_action_just_pressed("Interact"):
				if door_open == false:
					door_open = true
					get_parent().get_node("Door").position = Vector3(-2.748, -1.652, -5.749)
				else:
					door_open = false
					get_parent().get_node("Door").position = Vector3(-2.748, 2.016, -5.749)
					
	velocity.y += -gravity * delta
	var input = Input.get_vector("A", "D", "W", "S")
	var movement_dir = transform.basis * Vector3(input.x, 0, input.y)
	velocity.x = movement_dir.x * speed
	velocity.z = movement_dir.z * speed

	move_and_slide()
	if is_on_floor() and Input.is_action_just_pressed("Jump"):
		velocity.y = jump_speed

func _input(event):
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if Input.is_action_just_pressed("Sprint"):
		speed = 12
		emit_signal("Sprinting")
	elif Input.is_action_just_released("Sprint"):
		speed = 6
		emit_signal("Walking")
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$Camera3D.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))

func Reset():
	ResetSpeed = true
	speed = 6
�i�TSBӮX�a�Wextends Node3D

var is_sprinting = false
#const BarSize = $UI/Stamina_Top.size.x

func _ready():
	$Character.connect("Sprinting", Sprinting)
	$Character.connect("Walking", Walking)

func _process(_delta):
	var stretch_compensate = 800 / 400
	#var sprint_vector2 = Vector2($UI/Stamina_Top.size - stretch_compensate)
	#var walk_vector2 = Vector2($UI/Stamina_Top.size + stretch_compensate)
	if is_sprinting == true:
		if $UI/Stamina_Top.size.x > 0:
			$UI/Stamina_Top.size.x = $UI/Stamina_Top.size.x - stretch_compensate
	if is_sprinting == false:
		if $UI/Stamina_Top.size.x < 800:
			$UI/Stamina_Top.size.x = $UI/Stamina_Top.size.x + stretch_compensate

func Sprinting():
	is_sprinting = true

func  Walking():
	is_sprinting = false
��Y�RSRC                    PackedScene            ��������                                            �      resource_local_to_scene    resource_name    background_mode    background_color    background_energy_multiplier    background_intensity    background_canvas_max_layer    background_camera_feed_id    sky    sky_custom_fov    sky_rotation    ambient_light_source    ambient_light_color    ambient_light_sky_contribution    ambient_light_energy    reflected_light_source    tonemap_mode    tonemap_exposure    tonemap_white    ssr_enabled    ssr_max_steps    ssr_fade_in    ssr_fade_out    ssr_depth_tolerance    ssao_enabled    ssao_radius    ssao_intensity    ssao_power    ssao_detail    ssao_horizon    ssao_sharpness    ssao_light_affect    ssao_ao_channel_affect    ssil_enabled    ssil_radius    ssil_intensity    ssil_sharpness    ssil_normal_rejection    sdfgi_enabled    sdfgi_use_occlusion    sdfgi_read_sky_light    sdfgi_bounce_feedback    sdfgi_cascades    sdfgi_min_cell_size    sdfgi_cascade0_distance    sdfgi_max_distance    sdfgi_y_scale    sdfgi_energy    sdfgi_normal_bias    sdfgi_probe_bias    glow_enabled    glow_levels/1    glow_levels/2    glow_levels/3    glow_levels/4    glow_levels/5    glow_levels/6    glow_levels/7    glow_normalized    glow_intensity    glow_strength 	   glow_mix    glow_bloom    glow_blend_mode    glow_hdr_threshold    glow_hdr_scale    glow_hdr_luminance_cap    glow_map_strength 	   glow_map    fog_enabled    fog_light_color    fog_light_energy    fog_sun_scatter    fog_density    fog_aerial_perspective    fog_sky_affect    fog_height    fog_height_density    volumetric_fog_enabled    volumetric_fog_density    volumetric_fog_albedo    volumetric_fog_emission    volumetric_fog_emission_energy    volumetric_fog_gi_inject    volumetric_fog_anisotropy    volumetric_fog_length    volumetric_fog_detail_spread    volumetric_fog_ambient_inject    volumetric_fog_sky_affect -   volumetric_fog_temporal_reprojection_enabled ,   volumetric_fog_temporal_reprojection_amount    adjustment_enabled    adjustment_brightness    adjustment_contrast    adjustment_saturation    adjustment_color_correction    script    exposure_sensitivity    exposure_multiplier    auto_exposure_enabled    auto_exposure_scale    auto_exposure_speed    dof_blur_far_enabled    dof_blur_far_distance    dof_blur_far_transition    dof_blur_near_enabled    dof_blur_near_distance    dof_blur_near_transition    dof_blur_amount    auto_exposure_min_sensitivity    auto_exposure_max_sensitivity    lightmap_size_hint 	   material    custom_aabb    flip_faces    add_uv2    uv2_padding    size    subdivide_width    subdivide_height    subdivide_depth    render_priority 
   next_pass    transparency    blend_mode 
   cull_mode    depth_draw_mode    no_depth_test    shading_mode    diffuse_mode    specular_mode    disable_ambient_light    vertex_color_use_as_albedo    vertex_color_is_srgb    albedo_color    albedo_texture    albedo_texture_force_srgb    albedo_texture_msdf 	   metallic    metallic_specular    metallic_texture    metallic_texture_channel 
   roughness    roughness_texture    roughness_texture_channel    emission_enabled 	   emission    emission_energy_multiplier    emission_operator    emission_on_uv2    emission_texture    normal_enabled    normal_scale    normal_texture    rim_enabled    rim 	   rim_tint    rim_texture    clearcoat_enabled 
   clearcoat    clearcoat_roughness    clearcoat_texture    anisotropy_enabled    anisotropy    anisotropy_flowmap    ao_enabled    ao_light_affect    ao_texture 
   ao_on_uv2    ao_texture_channel    heightmap_enabled    heightmap_scale    heightmap_deep_parallax    heightmap_flip_tangent    heightmap_flip_binormal    heightmap_texture    heightmap_flip_texture    subsurf_scatter_enabled    subsurf_scatter_strength    subsurf_scatter_skin_mode    subsurf_scatter_texture &   subsurf_scatter_transmittance_enabled $   subsurf_scatter_transmittance_color &   subsurf_scatter_transmittance_texture $   subsurf_scatter_transmittance_depth $   subsurf_scatter_transmittance_boost    backlight_enabled 
   backlight    backlight_texture    refraction_enabled    refraction_scale    refraction_texture    refraction_texture_channel    detail_enabled    detail_mask    detail_blend_mode    detail_uv_layer    detail_albedo    detail_normal 
   uv1_scale    uv1_offset    uv1_triplanar    uv1_triplanar_sharpness    uv1_world_triplanar 
   uv2_scale    uv2_offset    uv2_triplanar    uv2_triplanar_sharpness    uv2_world_triplanar    texture_filter    texture_repeat    disable_receive_shadows    shadow_to_opacity    billboard_mode    billboard_keep_scale    grow    grow_amount    fixed_size    use_point_size    point_size    use_particle_trails    proximity_fade_enabled    proximity_fade_distance    msdf_pixel_range    msdf_outline_size    distance_fade_mode    distance_fade_min_distance    distance_fade_max_distance    custom_solver_bias    margin    data    backface_collision    radius    height    shader 	   _bundled       Script    res://Primary3D.gd ��������   Script    res://Character.gd ��������   Script    res://UI.gd ��������   Shader    res://Stamina_Bottom.tres !��vС�|   Shader    res://Stamina_Top.tres  ֈL� S      local://Environment_264ps �      (   local://CameraAttributesPractical_w7r6e �         local://BoxMesh_0668j 	      !   local://StandardMaterial3D_1otl8 5      $   local://ConcavePolygonShape3D_g1rp2 p         local://BoxMesh_chlla R      $   local://ConcavePolygonShape3D_wgfbh j         local://BoxMesh_ltm7b L      $   local://ConcavePolygonShape3D_t6hgu d         local://BoxShape3D_3dx3h F         local://CapsuleShape3D_tmtar a         local://ShaderMaterial_o7nb1 �         local://ShaderMaterial_s0fnr �         local://PackedScene_72cad �         Environment                     �?  �?  �?  �?`         CameraAttributesPractical    `         BoxMesh    u         @   @   @`         StandardMaterial3D    �      ���>���>���>  �?`         ConcavePolygonShape3D    �   #   $      �   ?   ?   ?   ?   ?   �   �   ?   ?   ?   ?   ?   �   ?   �   �   ?   ?   ?   �   �   ?   �   ?   �   �   �   ?   �   �   �   �   ?   �   �   ?   ?   ?   ?   ?   �   ?   �   ?   ?   ?   �   ?   �   �   ?   �   ?   �   ?   �   �   ?   ?   �   �   �   �   ?   ?   �   �   ?   �   �   �   ?   ?   ?   �   ?   ?   ?   ?   �   �   ?   ?   �   ?   �   ?   ?   �   �   �   ?   ?   �   ?   �   �   �   ?   �   ?   ?   �   �   �   �   �`         BoxMesh    `         ConcavePolygonShape3D    �   #   $      �   ?   ?   ?   ?   ?   �   �   ?   ?   ?   ?   ?   �   ?   �   �   ?   ?   ?   �   �   ?   �   ?   �   �   �   ?   �   �   �   �   ?   �   �   ?   ?   ?   ?   ?   �   ?   �   ?   ?   ?   �   ?   �   �   ?   �   ?   �   ?   �   �   ?   ?   �   �   �   �   ?   ?   �   �   ?   �   �   �   ?   ?   ?   �   ?   ?   ?   ?   �   �   ?   ?   �   ?   �   ?   ?   �   �   �   ?   ?   �   ?   �   �   �   ?   �   ?   ?   �   �   �   �   �`         BoxMesh    `         ConcavePolygonShape3D    �   #   $      �   ?   ?   ?   ?   ?   �   �   ?   ?   ?   ?   ?   �   ?   �   �   ?   ?   ?   �   �   ?   �   ?   �   �   �   ?   �   �   �   �   ?   �   �   ?   ?   ?   ?   ?   �   ?   �   ?   ?   ?   �   ?   �   �   ?   �   ?   �   ?   �   �   ?   ?   �   �   �   �   ?   ?   �   �   ?   �   �   �   ?   ?   ?   �   ?   ?   ?   ?   �   �   ?   ?   �   ?   �   ?   ?   �   �   �   ?   ?   �   ?   �   �   �   ?   �   ?   ?   �   �   �   �   �`         BoxShape3D    `         CapsuleShape3D    `         ShaderMaterial    �            `         ShaderMaterial    �            `         PackedScene    �      	         names "   0   
   Primary3D    script    Node3D    WorldEnvironment    environment    camera_attributes    Floor 
   transform    mesh    surface_material_override/0    MeshInstance3D    StaticBody3D    CollisionShape3D    shape    Door    DoorControls    DoorControls_InteractArea    Area3D 
   Character    CharacterBody3D 	   Camera3D 
   RayCast3D    target_position    collide_with_areas    UI    layout_mode    anchors_preset    offset_right    offset_bottom    Control    FakeCurser    anchor_left    anchor_top    anchor_right    anchor_bottom    offset_left    offset_top    metadata/_edit_use_anchors_    Panel    Stamina_Bottom 	   material    Stamina_Top    E_To_Interact_Label !   theme_override_colors/font_color $   theme_override_font_sizes/font_size    text    horizontal_alignment    Label    	   variants    /                                   |r2B    �a�    ��
=    S$>    _B��кmS>}v�=                       �?    ���/      �?              �?                  @     �0       @               @�5�    �i�            ;6@@            *Wl@            ��=;�/�%@����                     ��?            ��_?            }��>��Q;��?e«�                       �?              �?              �?        9��>      	                 �?              �?              �?      �?          
        �?              �?              �?    ���?                 @�                         B                  ����     �A     ZA   ~ ��   ���@               ?     �A    ��     HD   ����             �FD    @FD     �D    �LD                 �?   2         E To Interact       node_count             nodes     &  ��������       ����                            ����                           
      ����               	                       ����                          ����                           
      ����      	      
                    ����                     ����                     
      ����                                ����        	             ����                          ����                          ����                           ����                          ����                                ����                          ����                                 ����                                            &      ����                            !      "      #      $                    %                 &   '   ����   (   !                  "       #   !   "   "   #   $   $      %      &   %                 &   )   ����   (   '                  "       #   !   "   "   #   $   $      %      &   %                 /   *   ����	         #   (   $   )      *      +   +   ,   ,   -   -   .   .                conn_count              conns               node_paths              editable_instances              version       `      RSRC�7��U6d�ERSRC                    VisualShader            ��������                                            $      resource_local_to_scene    resource_name    output_port_for_preview    default_input_values    expanded_output_ports 	   operator    script    code    graph_offset    mode    modes/blend    flags/skip_vertex_transform    flags/unshaded    flags/light_only    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections        &   local://VisualShaderNodeColorOp_0sq3h d         local://VisualShader_77ktk �         VisualShaderNodeColorOp                                 ��L>                                      VisualShader          +  shader_type canvas_item;
render_mode blend_mix;




void fragment() {
// ColorOp:2
	vec3 n_in2p0 = vec3(0.20000, 0.00000, 0.00000);
	vec3 n_in2p1 = vec3(0.00000, 0.00000, 0.00000);
	vec3 n_out2p0 = vec3(1.0) - (vec3(1.0) - n_in2p0) * (vec3(1.0) - n_in2p1);


// Output:0
	COLOR.rgb = n_out2p0;


}
 	                                   
   ��B�tC                               RSRCRSRC                    VisualShader            ��������                                            $      resource_local_to_scene    resource_name    output_port_for_preview    default_input_values    expanded_output_ports 	   operator    script    code    graph_offset    mode    modes/blend    flags/skip_vertex_transform    flags/unshaded    flags/light_only    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections        &   local://VisualShaderNodeColorOp_maj24 d         local://VisualShader_n8p7x �         VisualShaderNodeColorOp                                        ?   A                              VisualShader          ,  shader_type canvas_item;
render_mode blend_mix;




void fragment() {
// ColorOp:2
	vec3 n_in2p0 = vec3(0.00000, 0.50000, 10.00000);
	vec3 n_in2p1 = vec3(0.00000, 0.00000, 0.00000);
	vec3 n_out2p0 = vec3(1.0) - (vec3(1.0) - n_in2p0) * (vec3(1.0) - n_in2p1);


// Output:0
	COLOR.rgb = n_out2p0;


}
 	                                   
     �A  �B                               RSRC[ O#������c��+`extends Control

var is_sprinting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("/root/Primary3D")
-�hF�ŰI[remap]

path="res://.godot/exported/133200997/export-a760568f5c084056965d55de6439dc53-primary_3d.scn"
��G���[remap]

path="res://.godot/exported/133200997/export-0fc9df56efb8dd4291a188b7dbd20cdf-Stamina_Bottom.res"
��X��[remap]

path="res://.godot/exported/133200997/export-29e04b2a507ad1490658bea649d50e6c-Stamina_Top.res"
7�κQC}list=Array[Dictionary]([])
��>mZ   �q5�s�2   res://primary_3d.tscn!��vС�|   res://Stamina_Bottom.tres ֈL� S   res://Stamina_Top.tres�z\�ECFG      application/config/name         TechFest 23-24     application/run/main_scene          res://primary_3d.tscn      application/config/features(   "         4.1    GL Compatibility       application/config/icon         res://icon.svg  "   display/window/size/viewport_width      �  #   display/window/size/viewport_height      8     display/window/stretch/mode         canvas_items   input/W�              deadzone      ?      events                  InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode           echo          script         input/A�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   A   	   key_label             unicode           echo          script         input/S�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   S   	   key_label             unicode           echo          script         input/D�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode           echo          script      
   input/Jump�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode       	   key_label             unicode           echo          script         input/Sprint�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script         input/Interact�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   E   	   key_label             unicode    e      echo          script      #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility磰v����c�