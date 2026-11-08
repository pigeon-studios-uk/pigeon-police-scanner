# Changelog

All notable changes to Pigeon Police Scanner are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project uses [Semantic Versioning](https://semver.org/spec/v2.0.0.html):

- **Major** versions can need changes to your configuration or other resources. Read the **Upgrade notes**.
- **Minor** versions add features without breaking existing setups.
- **Patch** versions fix bugs only.

## [Unreleased]

First release.

### Highlights

- GTA's own police radio reports, in and near emergency vehicles and at stations
- Optional for on-duty police anywhere, on Qbox, QBCore and ESX
- `/scanner` to turn it off, remembered
- `/scanner test` to listen to every report
- 23 languages

### Added

- GTA's police radio reports played every `Config.MinSeconds` to `Config.MaxSeconds`, never the same twice in a row, from 50 in `Config.Reports`.
- `Config.Where`: in or near emergency vehicles, at police stations (`Config.Stations`), for on-duty police on Qbox, QBCore and ESX, or everywhere.
- `/scanner` to turn it off and on for each player, remembered between sessions, and `/scanner test` to play each report.
- `SetEnabled` and `IsListening` client exports.
- Messages in 23 languages, following ox_lib's language with `Config.Locale = 'auto'`.
- Update checker from the Pigeon Studios version registry.

[Unreleased]: https://github.com/pigeon-studios-uk/pigeon-police-scanner/commits/main
