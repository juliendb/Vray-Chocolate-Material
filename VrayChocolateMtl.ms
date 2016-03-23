plugin material VrayChocolateMtl
name:"VrayChocolateMtl"
classID:#(0x39682b7e, 0x2532c28e)
extends:VRayFastSSS2 replaceUi:true
(
	parameters mainChocolate rollout:paramsChocolate
	(
		multDiffuse type:#float default:0 ui:_multDiffuse

		useScatterGI type:#Boolean default:true ui:_useScatterGI
		useReflections type:#Boolean default:false ui:_useReflections

		colorOverall type:#color default:[220,220,220] ui:_colorOverall
		colorDiffuse type:#color default:[99,61,38] ui:_colorDiffuse
		colorScatter type:#color default:[159,98,62] ui:_colorScatter


		colorSpecular type:#color default:[255,255,255] ui:_colorSpecular
		multIor type:#float default:1.8 ui:_multIor
		multSpecular type:#float default:0.6 ui:_multSpecular
		glossSpecular type:#float default:0.6 ui:_glossSpecular
		subdvSpecular type:#float default:16 ui:_subdvSpecular


		useOverallMap type:#Boolean default:true ui:_useOverallMap
		multOverallMap type:#float default:100 ui:_multOverallMap
		overallMap type:#texturemap ui:_overallMap subanim:true
		
		useDiffuseMap type:#Boolean default:true ui:_useDiffuseMap
		multDiffuseMap type:#float default:100 ui:_multDiffuseMap
		diffuseMap type:#texturemap ui:_diffuseMap subanim:true

		useBumpMap type:#Boolean default:true ui:_useBumpMap
		multBumpMap type:#float default:30 ui:_multBumpMap
		bumpMap type:#texturemap ui:_bumpMap subanim:true

		useDisplaceMap type:#Boolean default:true ui:_useDisplaceMap
		multDisplaceMap type:#float default:10 ui:_multDisplaceMap
		displaceMap type:#texturemap ui:_displaceMap subanim:true


		-- General
		on multDiffuse set val do delegate.diffuse_amount = val
		on useScatterGI set val do delegate.scatter_gi = val
		on useReflections set val do delegate.trace_reflections = val

		-- Colors
		on colorOverall set val do delegate.overall_color = val
		on colorDiffuse set val do delegate.diffuse_color = delegate.sub_surface_color = val
		on colorScatter set val do delegate.scatter_color = val

		-- Specular & Diffuse
		on colorSpecular set val do delegate.specular_color = val
		on multIOR set val do delegate.ior = val
		on multSpecular set val do delegate.specular_amount = val
		on glossSpecular set val do delegate.specular_glossiness = val
		on subdvSpecular set val do delegate.specular_subdivs = val

		-- Overall Map
		on useOverallMap set val do delegate.texmap_overall_color_on = val
		on multOverallMap set val do delegate.texmap_overall_color_multiplier = val
		on overallMap set val do delegate.texmap_overall_color = val
		
		-- Diffuse Map
		on useDiffuseMap set val do delegate.texmap_diffuse_color_on = val
		on multDiffuseMap set val do delegate.texmap_diffuse_color_multiplier = val
		on diffuseMap set val do delegate.texmap_diffuse_color = val

		-- Bump Map
		on useBumpMap set val do delegate.texmap_bump_on = val
		on multBumpMap set val do delegate.texmap_bump_multiplier = val
		on bumpMap set val do delegate.texmap_bump = val

		-- Displacement Map
		on useDisplaceMap set val do delegate.texmap_displacement_on = val
		on multDisplaceMap set val do delegate.texmap_displacement_multiplier = val
		on displaceMap set val do delegate.texmap_displacement = val
	)

	rollout paramsChocolate "Parameters VrayChocolate"
	(
		Group "General"
		(
			label lbl_colors "Choose colors" offset:[25,0] align:#left
			dropdownlist _listColors "" items:#("Chocolate Milk", "Chocolate Black", "Chocolate White") height:8 width:150 offset:[100,-22]

			label lbl_type "Choose type" offset:[30,5] align:#left
			dropdownlist _listType "" items:#("Solid", "Liquid", "Ice cream") height:8 width:150 offset:[100,-22]

	
			label lbl_diffuse "Diffuse Amount" offset:[15,15] align:#left
			slider _multDiffuse "" orient:#horizontal scale:0.01 Ticks:10 width:130 type:#float range:[0,1,0] offset:[-75,-30] align:#right
			spinner _editDiffuse "" width:50 scale:0.01 type:#float range:[0,1,0] offset:[-25,-27] align:#right


			checkBox _useScatterGI "Scatter GI" offset:[40,10] align:#left
			checkBox _useReflections "Reflections" offset:[-80,-20] align:#right
		)

		Group "Colors"
		(
			colorpicker _colorOverall "Overall :" align:#left
			colorpicker _colorDiffuse "Diffus :" align:#left offset:[100, -25]
			colorpicker _colorScatter "Scatter :" align:#left offset:[205, -25]
		)

		Group "Specular"
		(
			colorpicker _colorSpecular "Color :" align:#left offset:[5, 5]


			label lbl_ior "IOR" offset:[70,20] align:#left
			slider _multIor "" orient:#horizontal scale:0.1 Ticks:10 width:130 type:#float range:[0,26,1.8] offset:[-75,-30] align:#right
			spinner _editIor "" width:50 scale:0.1 type:#float range:[0,26,1.8] offset:[-25,-27] align:#right

			label lbl_specular "Amount" offset:[50,15] align:#left
			slider _multSpecular "" orient:#horizontal scale:0.1 Ticks:10 width:130 type:#float range:[0,1,0.6] offset:[-75,-30] align:#right
			spinner _editMultSpecular "" width:50 scale:0.1 type:#float range:[0,1,0.6] offset:[-25,-27] align:#right

			label lbl_gloss "Glossiness" offset:[40,15] align:#left
			slider _glossSpecular "" orient:#horizontal scale:0.1 Ticks:10 width:130 type:#float range:[0,1,0.6] offset:[-75,-30] align:#right
			spinner _editGlossSpecular "" width:50 scale:0.1 type:#float range:[0,1,0.6] offset:[-25,-27] align:#right

			label lbl_subdv "Subdivsions" offset:[30,15] align:#left
			slider _subdvSpecular "" orient:#horizontal Ticks:10 width:130 type:#integer range:[0,120,16] offset:[-75,-30] align:#right
			spinner _editSubdvSpecular "" width:50 type:#integer range:[0,120,16] offset:[-25,-27] align:#right
		)

		Group "Overall Map"
		(
			spinner _multOverallMap "" align:#right type:#float scale:0.1 range:[0,100,100] enabled:useOverallMap fieldwidth:40 offset:[-215,0]
			checkBox _useOverallMap "" align:#left offset:[10, -20]
			mapbutton _overallMap "None" width:200  enabled:useOverallMap offset:[45, -25]
		)

		Group "Diffuse Map"
		(
			spinner _multDiffuseMap "" align:#right type:#float scale:0.1 range:[0,100,100] enabled:useDiffuseMap fieldwidth:40 offset:[-215,0]
			checkBox _useDiffuseMap "" align:#left offset:[10, -20]
			mapbutton _diffuseMap "None" width:200  enabled:useDiffuseMap offset:[45, -25]
		)

		Group "Bump Map"
		(
			spinner _multBumpMap "" align:#right type:#float scale:0.1 range:[0,100,100] enabled:useBumpMap fieldwidth:40 offset:[-215,0]
			checkBox _useBumpMap "" align:#left offset:[10, -20]
			mapbutton _bumpMap "None" width:200  enabled:useBumpMap offset:[45, -25]
		)

		Group "Displacement Map"
		(
			spinner _multDisplaceMap "" align:#right type:#float scale:0.1 range:[0,100,100] enabled:useDisplaceMap fieldwidth:40 offset:[-215,0]
			checkBox _useDisplaceMap "" align:#left offset:[10, -20]
			mapbutton _displaceMap "None" width:200  enabled:useDisplaceMap offset:[45, -25]
		)



		fn refresh = 
		(
			_editDiffuse.value = multDiffuse
			_editIor.value = multIor
			_editMultSpecular.value = multSpecular
			_editGlossSpecular.value = glossSpecular
			_editSubdvSpecular.value = subdvSpecular
		)


		on _multDiffuse changed val do _editDiffuse.value = val
		on _editDiffuse changed val do multDiffuse = _multDiffuse.value = val


		on _multIor changed val do _editIor.value = val
		on _editIor changed val do multIor = _multIor.value = val

		on _multSpecular changed val do _editMultSpecular.value = val
		on _editMultSpecular changed val do multSpecular = _multSpecular.value = val

		on _glossSpecular changed val do _editGlossSpecular.value = val
		on _editGlossSpecular changed val do glossSpecular = _glossSpecular.value = val

		on _subdvSpecular changed val do _editSubdvSpecular.value = val
		on _editSubdvSpecular changed val do subdvSpecular = _subdvSpecular.value = val


		on _useOverallMap changed val do _multOverallMap.enabled = _overallMap.enabled = useOverallMap
		on _useDiffuseMap changed val do _multDiffuseMap.enabled = _diffuseMap.enabled = useDiffuseMap
		on _useBumpMap changed val do _multBumpMap.enabled = _bumpMap.enabled = useBumpMap
		on _useDisplaceMap changed val do _multDisplaceMap.enabled = _displaceMap.enabled = useDisplaceMap


		on _listColors selected val do (

			-- Chocolate Milk
			if val == 1 do (
				colorOverall = color 220 220 220
				colorDiffuse = color 99 61 38
				colorScatter = color 126 78 49
				colorSpecular = color 255 255 255
			)

			-- Chocolate Black
			if val == 2 do (
				colorOverall = color 220 220 220
				colorDiffuse = color 38 25 12
				colorScatter = color 49 32 16
				colorSpecular = color 255 255 255
			)

			-- Chocolate White
			if val == 3 do (
				colorOverall = color 255 255 240
				colorDiffuse = color 250 232 189
				colorScatter = color 226 187 149
				colorSpecular = color 250 250 250
			)


			refresh()
		)


		on _listType selected val do (

			-- Solid
			if val == 1 do (
				multIor = 1.5
				multSpecular = 0.6
				glossSpecular = 0.6
			)

			-- Liquid
			if val == 2 do (
				multIor = 1.8
				multSpecular = 1
				glossSpecular = 0.8
			)

			-- Ice cream
			if val == 3 do (
				multIor = 1.8
				multSpecular = 1
				glossSpecular = 0.4
			)


			refresh()
		)


		on paramsChocolate open do refresh()
	)


	rollout paramsAbout "About" rolledUp:true
	(
		local ActualTime = getLocalTime()
		local copyright = "© " + (ActualTime[1] as string) + " Juliendb, All rights reserved"

		label lbl1 copyright align:#left
		hyperlink lbl2 "http://www.juliendb.fr" address:"http://www.juliendb.fr" align:#left
		label lbl3 "julien.debisschop@gmail.com" align:#left
	)



	on create do
	(
		delegate.prepass_rate = -1
		delegate.prepass_id = 0
		delegate.scale = 1.0
		delegate.ior = 1.8
		delegate.overall_color = (color 220 220 220)
		delegate.diffuse_color = (color 99 61 38)
		delegate.diffuse_amount = 1.0
		delegate.sub_surface_color = (color 99 61 38)
		delegate.scatter_color = (color 159 98 62)
		delegate.scatter_radius = 20
		delegate.phase_function = -0.4
		delegate.specular_color = (color 255 255 255)
		delegate.specular_amount = 0.6
		delegate.specular_glossiness = 0.6
		delegate.specular_subdivs = 16
		delegate.trace_reflections = false
		delegate.reflection_depth = 5
		delegate.single_scatter = 1
		delegate.single_scatter_subdivs = 8
		delegate.refraction_depth = 5
		delegate.front_lighting = true
		delegate.back_lighting = true
		delegate.scatter_gi = true
		delegate.prepass_LOD_threshold = 4.0
		delegate.interpolation_accuracy = 1.0
		delegate.prepass_blur = 1.2
		delegate.cutoff_threshold = 0.01
	)
)