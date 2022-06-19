---
--- Created by Waterpoloswwa
--- DateTime: 20/12/2019 22:32
---
fx_version 'adamant'
games { 'gta5' };

client_scripts {

}


client_scripts {
    'dependencies/NativeUI.lua',
    'config.lua',
	'client.lua'
}


server_scripts {
    'config.lua',
    'server.lua',
    '@mysql-async/lib/MySQL.lua',
}

dependencies {
	'es_extended'
}

print {

    'wAutoRebot by Wesley'
}