--[[
    Pigeon Police Scanner: English.

    To translate, copy this file to a new one named with the language's code (such as de.lua or pt-br.lua),
    change `Locales.en` to match (Locales.de), translate the text in quotes, and set Config.Locale.
    Keep words in {curly brackets} and ~GTA codes~ exactly as they are; they're filled in automatically.
]]

Locales = Locales or {}

Locales.en = {
    -- Title of the messages.
    title = 'Police scanner',
    -- After /scanner turns it on.
    on = 'Police scanner on.',
    -- After /scanner turns it off.
    off = 'Police scanner off.',
    -- {number} and {total} are numbers, {name} is the report's name, kept in English.
    testing = 'Report {number} of {total}: {name}',
    -- The chat suggestion for /scanner.
    usage = 'Turn the police scanner on or off, or test its reports.',
}
