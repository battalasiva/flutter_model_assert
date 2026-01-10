## 0.0.1

* TODO: Describe initial release.

## 0.0.2
- Added `detect<T>(json)` method for one-line model inspection
- Improved error logs to pinpoint exact mismatched attributes
- Added nested JSON field path reporting
- Removed schema burden from developer usage
- Optimized early failure to prevent runtime crashes

## 0.0.3
### Added
- Introduced `detectModel<T>(json, sample: modelInstance)` for one-line model inspection when debugging API crashes.
- Supports deep nested JSON validation (3–N layers) to pinpoint exact mismatched field paths.
- Prevents runtime crashes by reporting contract breakage before model parsing.

### Improved
- Recursive JSON walker to support nested-to-nested field path detection.
- Cleaned nullable type check logic (removed duplicate methods).
- More readable console mismatch reports with expected vs received runtime types.

### Notes
- Does not require manual schema definitions.
- Developer only provides a lightweight sample model instance using existing constructors.

## 0.0.4

### Added
- New `detect<T>(json)` API for debugging backend type regressions with a single line.
- Deep recursive JSON walker supporting unlimited nested layers (3–N levels).
- Nested list path support like `items[2].vendor.address.cityId`.
- Includes backend value and received runtime type in error report.
- Designed for QA/Staging to catch contract breaks before model parsing.

### Fixed
- Removed duplicated nullable check methods from earlier draft.
- Prevented unnecessary null comparison warnings in main library file.
- Package no longer depends on manual schema or descriptor files for detection.

### Developer Benefits
- Pinpoints exact error-causing attribute path in console.
- Prevents `fromJson()` crashes by validating JSON before parsing.
- Reduces debugging time for `double is not subtype of int` and similar errors.

### Notes
- Does **not auto-modify model types** (Flutter runtime reflection limitation).
- Intended for **on-demand debugging** when a type crash is encountered.

## 0.0.5

### 🚀 Major Release – New Architecture

This release introduces a **code-generation–based model contract validator**
to reliably detect backend type regressions in Flutter applications.

### ✨ Added
- `@ModelAssert()` annotation for model contract generation
- Build-time extraction of model field paths and expected types
- Runtime API to validate backend JSON **before `fromJson()`**
- Deep nested object support
- List and nested list support with index paths
- Clear, human-readable error reports showing:
  - exact field path
  - expected type
  - received backend type and value

### 🧠 Developer Experience
- One-time annotation per model
- One-time `build_runner` execution
- One-line runtime validation when debugging API crashes

### 🛑 Prevents
- `double is not a subtype of int`
- `String is not a subtype of int?`
- Silent backend API regressions

### ⚠️ Notes
- Requires `build_runner`
- Intended for debug, QA, and staging environments
- Does not auto-modify model types (manual fix required)

---
