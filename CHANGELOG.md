# Changelog

All notable changes to VisualCopy will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.0.0] - 2026-02-03

### 🎉 Initial Release

#### Added
- **Core Sanitization Engine:** Real-time clipboard cleaning using CSS injection and event interception
- **Trap Detection System:** Pattern-based identification of hidden AI prompt instructions
- **Off-Screen Rendering:** Preserves text formatting (newlines, lists) while stripping malicious elements
- **Shadow DOM Notifications:** High-visibility "Good to Go 👍" feedback system
- **Cross-Browser Support:** Compatible with Firefox 142+ and Chromium-based browsers (Chrome, Brave, Edge)
- **Privacy-First Architecture:** Zero data collection, local-only processing
- **Context Menu Integration:** Right-click option for manual sanitization
- **Frame-Aware Operation:** Works across iframes and embedded content

#### Security
- Enforced `data_collection_permissions: ["none"]` in Firefox manifest
- Implemented fail-safe fallback to preserve original clipboard on errors
- Limited permissions to `clipboardWrite`, `scripting`, `activeTab`, `contextMenus`

#### Documentation
- Comprehensive README.md with installation guides for Firefox and Chrome
- Technical deep-dive in ARCHITECTURE.md
- Privacy policy and threat analysis in SECURITY.md
- Contribution guidelines in CONTRIBUTING.md
- MIT License for open-source distribution

---

## [Unreleased]

### Planned Features
- [ ] **Options Page:** User-configurable trap selectors and phrase patterns
- [ ] **Safari Extension:** Port to Safari App Extensions API for macOS/iOS
- [ ] **Internationalization:** Localized notification messages (i18n)
- [ ] **Advanced Detection:** Machine learning model for trap pattern recognition
- [ ] **Browser Action Popup:** Statistics dashboard showing sanitization events
- [ ] **Unicode Normalization:** Handle lookalike characters and zero-width spaces
- [ ] **Community Filter Lists:** Import/export custom selector databases
- [ ] **Automated Testing:** Puppeteer/Playwright test suite
- [ ] **Performance Metrics:** Telemetry (opt-in) for sanitization success rates

---

## Version History

### Version Numbering

We follow [Semantic Versioning](https://semver.org/):
- **MAJOR** (X.0.0): Incompatible API changes or manifest updates
- **MINOR** (1.X.0): New features in a backward-compatible manner
- **PATCH** (1.0.X): Backward-compatible bug fixes

---

## [0.9.0-beta] - 2026-01-28 (Pre-Release)

### Added
- Initial prototype with basic trap detection
- CSS injection for `[data-ai-instructions]` selector
- Simple notification system (non-Shadow DOM)

### Known Issues
- Notifications obscured by website modals (fixed in 1.0.0)
- Limited trap phrase database (expanded in 1.0.0)
- No Firefox-specific optimizations (added in 1.0.0)

---

## Contribution Notes

**How to Report Bugs:**
- Check if the issue exists in the [GitHub Issues](https://github.com/Shiva-destroyer/VisualCopy/issues) tracker
- Include browser version, OS, and console errors
- Provide steps to reproduce the bug

**How to Suggest Features:**
- Open a GitHub Discussion or Feature Request issue
- Explain the use case and expected behavior
- Consider submitting a Pull Request if you can implement it!

---

**[← Back to README](README.md)**
