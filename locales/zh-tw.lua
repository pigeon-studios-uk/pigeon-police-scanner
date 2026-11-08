--[[
    Pigeon Police Scanner: Traditional Chinese (繁體中文).

    Translated from locales/en.lua, which has the notes on each line. If something reads
    wrong, please send a fix (see the README's Contributing section). Set Config.Locale = 'zh-tw'
    to use it, or leave it on 'auto' and set ox_lib's language.
]]

Locales = Locales or {}

Locales['zh-tw'] = {
    title = '警用無線電',
    on = '警用無線電已開啟。',
    off = '警用無線電已關閉。',
    testing = '報告 {number}/{total}：{name}',
    usage = '開啟或關閉警用無線電，或測試其報告。',
}
