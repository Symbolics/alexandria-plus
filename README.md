
<!-- PROJECT SHIELDS -->

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MS-PL License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<p align="center">
  <!-- <a href="https://github.com/Symbolics/alexandria-plus"> -->
  <!--   <img src="https://lisp-stat.dev/images/stats-image.svg" alt="Logo" width="80" height="80"> -->
  <!-- </a> -->

  <h3 align="center">Alexandria+</h3>

  <p align="center">
Alexandria+ is a slightly less conservative set of utilities, similar in spirit to <a href="https://gitlab.common-lisp.net/alexandria/alexandria" alexandria.
	<br />
    <a href="https://Symbolics.github.io/alexandria-plus"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/Symbolics/alexandria-plus/issues">Report Bug</a>
    ·
    <a href="https://github.com/Symbolics/alexandria-plus/issues">Request Feature</a>
    ·
    <a href="https://lisp-stat.github.io/data-frame/">Reference Manual</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
	<li><a href="#resources">Resources</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About the Project

We generally follow the three guiding principles of Alexandria:

 * Utilities, not extensions: Alexandria will not contain conceptual
   extensions to Common Lisp, instead limiting itself to tools and
   utilities that fit well within the framework of standard ANSI
   Common Lisp. Test-frameworks, system definitions, logging
   facilities, serialization layers, etc. are all outside the scope of
   Alexandria as a library, though well within the scope of Alexandria
   as a project.

 * Conservative: Alexandria limits itself to what project members
   consider conservative utilities. Alexandria does not and will not
   include anaphoric constructs, loop-like binding macros, etc.

 * Portable: Alexandria limits itself to portable parts of Common
   Lisp. Even apparently conservative and useful functions remain
   outside the scope of Alexandria if they cannot be implemented
   portably. Portability is here defined as portable within a
   conforming implementation: implementation bugs are not considered
   portability issues.


An additional guiding principal is that we only add functionality that is not already available in `UIOP`, `OSICAT` or `alexandria`, but required for multiple projects that we work on. Although portable code is desirable, it is not tested on anything except SBCL, CCL and Genera.

Another library, with much more functionality, is [serapeum](https://github.com/ruricolist/serapeum).  Sadly it is not split into separate ASDF systems, so you need to haul in all 400+ symbols to use it. If that's OK with you, it may be a better choice.


### Built With

* No dependencies

<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these steps:

### Prerequisites

An ANSI Common Lisp implementation. Developed and tested with
[SBCL](https://www.sbcl.org/), Genera and
[CCL](https://github.com/Clozure/ccl).

### Quicklisp Installation

```lisp
(ql:quickload :alexandria+)
```

### Manual Installation

1. Clone the repository
   ```sh
   cd ~/quicklisp/local-projects &&
   git clone https://github.com/Symbolics/alexandria-plus.git
   ```
2. Reset the ASDF source-registry to find the new system (from the REPL)
   ```lisp
   (asdf:clear-source-registry)
   ```
3. Load the system
   ```lisp
   (ql:quickload :alexandria+)
   ```

<!-- USAGE EXAMPLES -->
## Usage

The `alexandria+` source code is organised the same as the `alexandria` source. For example the alist and plist utilities are in `lists.lisp` in both `alexandria` and `alexandria+`.  It is intended to be used alongside `alexandria`, e.g. `(:use :alexandria :alexandria+)`

For more examples, please refer to the [Documentation](https://Symbolics.github.io/alexandria-plus).


<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/Symbolics/alexandria-plus/issues) for a list of proposed features (and known issues).

## Resources


<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are greatly appreciated.  Please see [CONTRIBUTING.md](CONTRIBUTING.md) for details on the code of conduct, and the process for submitting pull requests.

<!-- LICENSE -->
## License

Distributed under the MS-PL License. See [LICENSE](LICENSE) for more information.



<!-- CONTACT -->
## Contact

Project Link: [https://github.com/Symbolics/alexandria-plus](https://github.com/Symbolics/alexandria-plus)



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Symbolics/alexandria-plus.svg?style=for-the-badge
[contributors-url]: https://github.com/Symbolics/alexandria-plus/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Symbolics/alexandria-plus.svg?style=for-the-badge
[forks-url]: https://github.com/Symbolics/alexandria-plus/network/members
[stars-shield]: https://img.shields.io/github/stars/Symbolics/alexandria-plus.svg?style=for-the-badge
[stars-url]: https://github.com/Symbolics/alexandria-plus/stargazers
[issues-shield]: https://img.shields.io/github/issues/Symbolics/alexandria-plus.svg?style=for-the-badge
[issues-url]: https://github.com/Symbolics/alexandria-plus/issues
[license-shield]: https://img.shields.io/github/license/Symbolics/alexandria-plus.svg?style=for-the-badge
[license-url]: https://github.com/Symbolics/alexandria-plus/blob/master/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/company/Symbolics/
