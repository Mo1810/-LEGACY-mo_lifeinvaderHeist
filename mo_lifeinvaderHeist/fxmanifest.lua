fx_version 'bodacious'
game 'gta5' 

author 'Mo1810#4230'
version '1.1.2'

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

dependencies {
	'es_extended'
}
