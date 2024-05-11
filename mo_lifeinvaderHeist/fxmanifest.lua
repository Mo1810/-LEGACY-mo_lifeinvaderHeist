fx_version 'cerulean'
game 'gta5' 

author 'Mo1810'
version '1.2.1'

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"lifeinvaderHeist-s.lua",
}

client_scripts {
	"lifeinvaderHeist-c.lua",
}

shared_scripts {
 "@es_extended/locale.lua",
	"@es_extended/imports.lua",
 "config.lua",
 "locales/*.lua"
}

dependencies {
	'es_extended'
}
