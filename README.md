# Functional Programming Project
# Elm Hacker News Client

A type-safe, functional Single Page Application (SPA) built with **Elm**. This application fetches top stories from the [Hacker News API](https://github.com/HackerNews/API) and provides a robust interface for browsing, sorting, and filtering posts.

It demonstrates core functional programming concepts and the reliability of **The Elm Architecture (TEA)**.

## Features

* **Live Data Fetching**: Retrieves real-time stories using `elm/http` and JSON decoders.
* **Dynamic Sorting**: Client-side sorting by Score, Title, or Posted Date.
* **Filtering System**: Options to toggle Job posts or Text-only content.
* **Smart Pagination**: Efficient list navigation implemented via a custom Cursor data structure.
* **Relative Time Parsing**: Custom logic to convert timestamps into human-readable format (e.g., "2 hours ago").
* **No Runtime Exceptions**: Leverages Elm's type system to ensure application stability.

## Tech Stack

* **Language**: [Elm 0.19](https://elm-lang.org/)
* **Testing**: `elm-test`
* **Package Manager**: `npm`

## Getting Started

To run this project locally on your machine, follow these steps:

### Prerequisites
* **Node.js** and **npm** installed.

### Installation & Running

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/MihaiFlorea6/Elm_Project.git](https://github.com/MihaiFlorea6/Elm_Project.git)
    cd Elm_Project
    ```

2.  **Install dependencies:**
    ```bash
    npm install
    ```

3.  **Start the development server:**
    We use `elm reactor` for rapid development.
    ```bash
    npx elm reactor
    ```

4.  **Open the application:**
    Open your browser and navigate to:
    `http://localhost:8000/src/Main.elm`

## Running Tests

The project includes a comprehensive test suite covering business logic, decoders, and view rendering.

To run the automated tests:

```bash
npm test
```
## Technologies
`Elm 0.19`, `The Elm Architecture (TEA)`, `elm/http`, `elm/json`, `elm-test`, `HTML/CSS`, `npm`.


