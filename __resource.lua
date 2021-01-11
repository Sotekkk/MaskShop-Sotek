fx_version 'adamant'
game 'gta5'

-----------IMPORTANT------------
client_scripts {
	'@es_extended/locale.lua',
}
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',

}
-----------IMPORTANT------------


server_scripts {
'server/*.lua'
}

client_scripts {
  'client/*.lua',
    'pmenu.lua',
    
}
