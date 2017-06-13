# Change Log

## [Unreleased](https://github.com/Techprimate/TPPDF/tree/HEAD)
[Full Changelog](https://github.com/Techprimate/TPPDF/compare/0.4.0...HEAD)

**Implemented enhancements:**

- Pagination styling using formats or closures.
- First and last pagination page can be set.
- Pages can be excluded from pagination.
- Created class `Table` to manage tables.
- Added extension `toTableContent` to class `String`, `NSAttributedString` and `UIImage`.
- Created Error enum `TPPDFError` for error handling.
- Added image rendering inside table
- Moved all error handling outside of framework

**Fixed bugs:**

**Closed issues:**

- Issue #5
- Issue #15
- Issue #16

**Merged pull requests:**

## [0.4.0](https://github.com/Techprimate/TPPDF/tree/0.4.0) (2017-06-05)
[Full Changelog](https://github.com/Techprimate/TPPDF/compare/0.3.0...0.4.0)

**Implemented enhancements:**

- Added property `landscapeSize` to `PageFormat` which returns the size as landscape
- Split `PDFGenerator` into multiple files
- Added Carthage support
- Added table styling

**Fixed bugs:**

**Closed issues:**

- Issue #2
- Issue #4
- Isseu #7

**Merged pull requests:**

## [0.3.0](https://github.com/Techprimate/TPPDF/tree/0.3.0) (2017-01-19)
[Full Changelog](https://github.com/Techprimate/TPPDF/compare/0.2.0...0.3.0)

**Implemented enhancements:**

- Added command for new page creation `creteNewPage()`
- Added image caption and how image should fit, as parameter in `addImage(image: UIImage, size: CGSize, caption: NSAttributedString, sizeFit: ImageSizeFit)`
- Image is moved to new page if there is not enough rest space
- Added pagination, define position using `paginationContainer`
- Added `imageQuality` to reduce pdf file size
- Added command `addImagesInRow(images: [UIImage], captions: [NSAttributedString], sizeFit: ImageSizeFit)` for rendering two images next to each other
- Images can be added to header or footer
- Line separator can be drawn in header or footer
- Text font in table can be modified in `addTable(..., textFont: UIFont)`
- Added paragraph support in table, moves to new page if not enough space
- Add metadata information to PDF file
- Improved PDF generation of large files
- Added command `setFont(font: UIFont)` to change the font in a container
- Added command `resetFont(container: Container)` to reset the font of a container to default

**Fixed bugs:**

**Closed issues:**

**Merged pull requests:**

- [#3](https://github.com/Techprimate/TPPDF/pull/3) from kf99916/master


## [0.2.0](https://github.com/Techprimate/TPPDF/tree/0.2.0) (2016-11-07)
[Full Changelog](https://github.com/Techprimate/TPPDF/compare/0.1.4...0.2.0)

**Implemented enhancements:**

- Updated to Swift 3.0

**Fixed bugs:**

**Closed issues:**

**Merged pull requests:**

## [0.1.5](https://github.com/Techprimate/TPPDF/tree/0.1.4) (2016-11-09)
[Full Changelog](https://github.com/Techprimate/TPPDF/compare/0.1.3...0.1.4)

**Implemented enhancements:**

**Fixed bugs:**

**Closed issues:**

**Merged pull requests:**

## [0.1.4](https://github.com/Techprimate/TPPDF/tree/0.1.4) (2016-08-24)
[Full Changelog](https://github.com/Techprimate/TPPDF/compare/0.1.3...0.1.4)

**Implemented enhancements:**

- Added offset command `SetOffset(points: CGFloat)`

**Fixed bugs:**

- Small link issues in `CHANGELOG.md`

**Closed issues:**

**Merged pull requests:**

## [0.1.3](https://github.com/Techprimate/TPPDF/tree/0.1.3) (2016-08-21)
[Full Changelog](https://github.com/Techprimate/TPPDF/compare/0.1.2...0.1.3)

**Implemented enhancements:**

- Added indentation command `SetIndentation(points: CGFloat)`

**Fixed bugs:**

**Closed issues:**

**Merged pull requests:**

## [0.1.2](https://github.com/Techprimate/TPPDF/tree/0.1.2) (2016-08-16)
[Full Changelog](https://github.com/Techprimate/TPPDF/compare/0.1.1...0.1.2)

**Implemented enhancements:**

**Fixed bugs:**

- Footer space is rendering correctly now

**Closed issues:**

**Merged pull requests:**