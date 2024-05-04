fx_version 'cerulean'
game 'gta5' 

author 'Mo1810'
version '1.2.1'

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"@es_extended/locale.lua",
	"lifeinvaderHeist-s.lua",
	"config.lua",
	"locales/de.lua",
	"locales/en.lua"
}

client_scripts {
	"@es_extended/locale.lua",
	"lifeinvaderHeist-c.lua",
	"config.lua",
	"locales/de.lua",
	"locales/en.lua"
}

shared_scripts {
	"@es_extended/imports.lua"
}

dependencies {
	'es_extended'
}
