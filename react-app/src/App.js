import "./App.scss";
import * as React from "react";
import { HashRouter, Routes, Route } from "react-router-dom";
import CssBaseline from "@mui/material/CssBaseline";
import Container from "@mui/material/Container";
import { createTheme, ThemeProvider } from "@mui/material/styles";
// Master Page Components
// Containers
import Home from "./views/home";
import MovieView from "./views/movie-view";
import MovieList from "./views/movie-list";

import { PRIMARY_COLOR } from "./styles/styles";

const theme = createTheme({
  palette: {
    primary: {
      main: PRIMARY_COLOR,
    },
  },
});

function App() {
  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <main className="srv srv-main">
        <Container className="srv srv--main-container">
          <HashRouter>
            <Routes>
              <Route path="/" element={<Home />} />
              <Route path="/movie-view/:id" element={<MovieView />} />
              <Route path="/movies" element={<MovieList />} />
            </Routes>
          </HashRouter>
        </Container>
      </main>
    </ThemeProvider>
  );
}

export default App;
