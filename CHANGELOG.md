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