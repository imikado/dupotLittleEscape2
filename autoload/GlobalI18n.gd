extends Node

const LANG_FR="fr"
const LANG_EN="en"

var lang=LANG_FR
static var trad_fr_list={
	GlobalPlayer.ACTION_CLOSE:"Fermer",
	GlobalPlayer.ACTION_OPEN:"Ouvrir",
	GlobalPlayer.ACTION_OBSERVE:"Observer",
	GlobalPlayer.ACTION_TAKE:"Prendre",
	GlobalPlayer.ACTION_USE:"Utiliser",
	GlobalPlayer.ACTION_WALK:"Marcher"
}

static func translate(key:String)->String:
	return trad_fr_list[key]
	
