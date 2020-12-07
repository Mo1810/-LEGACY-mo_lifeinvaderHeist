resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

dependencies {
	'es_extended',
	'esx_billing'
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"@es_extended/locale.lua",
	"lifeinvaderR-s.lua",
	"config.lua",
	"locales/de.lua",
	"locales/en.lua"
}

client_scripts {
	"@es_extended/locale.lua",
	"lifeinvaderR-c.lua",
	"config.lua",
	"locales/de.lua",
	"locales/en.lua"
}