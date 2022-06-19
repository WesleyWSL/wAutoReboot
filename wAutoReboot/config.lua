Config = {}

Config.DurationBetweenCheck = 5000

Config.Debug = false

-- Configuration du temps météorologique a config.

Config.Weather = {
    'overcast',
    'rain',
    'thunder'
}

-- Configuration sur le temps, paramétré en FR donc 19h30 = 19h=30

Config.AutoRebootsTime = {
    { hour = 1, min = 30 },
    { hour = 6, min = 30 },
	{ hour = 13, min = 00 },
    { hour = 19, min = 30 },
}

-- Message Météo Affichée en jeux au temps données, ( Avant 30min Message "Tempête en approche dans 30 minutes !")

Config.AlertTime = {
    { state = false, min = 30, reboot = false, message = 'Tempête en approche dans 30 minutes !' },
    { state = false, min = 15, reboot = false, message = 'La tempête arrive dans 15 minutes !', weather = 'overcast' },
    { state = false, min = 05, reboot = false, message = 'Alerte, tempête imminente. 5 minutes !', weather = 'rain' },
    { state = false, min = 03, reboot = false, message = 'Tempête, ranger vos véhicules et rentrer chez vous !', weather = 'thunder' },
    { state = false, min = 00, reboot = true, message = nil },
}
