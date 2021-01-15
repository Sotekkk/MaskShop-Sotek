ESX = nil

local incamera = false
function destorycam() 	
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    TriggerServerEvent('barbershop:removeposition')
end

function SAveSkinSOSomaness()
	TriggerEvent('skinchanger:getSkin', function(skin)
		LastSkin = skin
	end)
	TriggerEvent('skinchanger:getSkin', function(skin)
	TriggerServerEvent('Sotek:saveMask', skin)  
	end)
end 
----Menu



maskshop = {
	Base = { Header = {"shopui_title_movie_masks", "shopui_title_movie_masks"}, Color = {color_black}, Title = "Création Personnage" },
	Data = { currentMenu = "Magasin" },
	Events = {       

        onSelected = function(self,_, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            local btn = btn.name 
            local slide = btn.slidenum
            local check = btn.unkCheckbox   
            local currentMenu = self.Data.currentMenu    

            if currentMenu == "Magasin" then 
				DisplayRadar(true)                                           
				destorycam() 
				SetEntityInvincible(GetPlayerPed(-1), false)   
				FreezeEntityPosition(GetPlayerPed(-1), false)
                TriggerServerEvent('Sotek:pay')
				SAveSkinSOSomaness()
				ESX.ShowNotification("~g~Vespucci Masks\n~s~Vous venez d'acheter un masque pour ~g~15$") 
				CloseMenu(true) 
            end
        end,

        
        
        onButtonSelected = function(currentMenu, currentBtn, menuData, newButtons, self)

            if currentMenu == "Magasin" then 
                for k,v in pairs(maskshop.Menu["Magasin"].b) do 
                    if currentBtn - 1 == v.iterator then                
                        TriggerEvent('skinchanger:change', 'mask_1' , v.iterator)
                    end
                end
            end
 
        end,
        onAdvSlide = function(self, btn , currentBtn, currentButtons)

            if self.Data.currentMenu == "Magasin" then 
                if self.Data.currentMenu == "Magasin" then 
                    for k,v in pairs(maskshop.Menu['Magasin'].b) do 
                        if currentBtn.advSlider[3] == v.iterator then
                            TriggerEvent('skinchanger:change', 'mask_2', v.iterator) 
                        end
                    end
                end
            end
        end,

    },

Menu = {
    ["Magasin"] = {
        b = {
        }
    },
}
}
--blip
local posmagasin = {
    {x= -1337.69, y = -1277.76, z = 4.84 }
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k, v in pairs(posmagasin) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, posmagasin[k].x, posmagasin[k].y, posmagasin[k].z)
            if dist <= 10.0  then
                DrawMarker(2, posmagasin[k].x, posmagasin[k].y, posmagasin[k].z+0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 204, 204, 204, 200, true, false, 2, true, false, false, false)
            end
            if dist <= 2.0 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~magasin de masque~w~.")
                if IsControlJustPressed(1,51) then 	
                    maskshop.Menu["Magasin"].b = {}

                    TriggerEvent('skinchanger:getData', function(components, maxVals)
                        for i=0, maxVals.mask_1, 1 do
                            table.insert(maskshop.Menu["Magasin"].b, { name = "Masque N°" .. i , price = 15 , advSlider = {0,5,0},iterator = i })
                        end
                    end)
					SetEntityInvincible(GetPlayerPed(-1), true) 
		        	FreezeEntityPosition(GetPlayerPed(-1), true) 									
					SetEntityCoords(GetPlayerPed(-1), -1336.9627, -1277.15600, 4.5238-0.98, 0.0, 0.0, 0.0, 10)
					SetEntityHeading(GetPlayerPed(-1), 80.9283561706543)
					DisplayRadar(false) 
					local cam = {}				
					Citizen.Wait(1)
					cam = CreateCam("DEFAULT_SCRIPTED_Camera", 1)	
                    SetCamCoord(cam, -1338.06, -1277.10, 5.6238, 0.0, 0.0, 200.455696105957, 15.0, false, 0)
                    RenderScriptCams(1000, 1000, 1000, 1000, 1000)
					PointCamAtCoord(cam, -1336.9627, -1277.15600, 5.6238)                  	
                    CreateMenu(maskshop)
                end
                if IsControlJustPressed(1,177) then 
                    DisplayRadar(true)                                           
				    destorycam() 
				    SetEntityInvincible(GetPlayerPed(-1), false)   
				    FreezeEntityPosition(GetPlayerPed(-1), false)
				    ESX.ShowNotification("~g~Vespucci Masks\n~s~A bientôt !") 
				    CloseMenu(true) 
                end
            end
        end
    end
end)
Citizen.CreateThread(function()
	for _, pos in pairs(posmagasin) do
		blips = AddBlipForCoord(pos.x, pos.y, pos.z)
		SetBlipSprite(blips, 362)
		SetBlipScale(blips, 0.6)
		SetBlipDisplay(blips, 4)
		SetBlipColour(blips, 2)
		SetBlipAsShortRange(blips, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Magasins de Masque")
		EndTextCommandSetBlipName(blips)
	end
end)

