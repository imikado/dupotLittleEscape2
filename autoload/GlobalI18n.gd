extends Node

const LANG_FR = "fr"
const LANG_EN = "en"

var langList:Dictionary={
	0:LANG_FR,
	1:LANG_EN
}

func set_lang(index:int):
	TranslationServer.set_locale(langList[index])
