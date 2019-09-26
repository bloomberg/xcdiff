# Comparison Result

The result output should be easy to read and interpret. Its content is consistent regardles of the selected format (`console`, `json`, or `markdown`).

Each comparator is focused on a small area of the Xcode project and can produce, zore, one or more results.

Each result consists of:

### `CompareResult`
- `tag` (`String`) - Unique identifier of the comparator.
- `context` (`String`) - Information about the area of the project, usually specifies a target, configuration etc.
- `description` (`String?`) - Additional information that can help to understand the result.
- `onlyInFirst` (`[String]`) - Values that are not present in the second project.
- `onlyInSecond` (`[String]`) - Values that are not present in the first project.
- `differentValues` (`[DifferentValues`]) - Values that are present in both projects but are not identical (i.e. have different attributes).

If all three arrays (`onlyInFirst`, `onlyInSecond`, and `differentValues`) are empty, it means the result does not contain any differncess (✓ success).

### `DifferentValues`
- `context` (`String`) - Additional information that can help to understand the result.
- `first` (`String`) - Attribute found in the first project.
- `second` (`String`) - Attribute found in the second project.
