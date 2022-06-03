import * as React from "react";
import { useState, useEffect } from "react";
// material code
import Grid from "@mui/material/Grid";
import Stack from "@mui/material/Stack";
// css
import "./style.scss";
// Project components
import BusyIndicator from "../shared/busy-indicator";
import SearchBox from "../shared/search-box";
import MovieRow from "../shared/movie-row";
import { ReactComponent as NoMovie } from "../../icons/no-movie.svg";
// http apis
import { getMovies } from "../../http/get-movies";
import { getFeatured } from "../../http/get-featured";
import { getByCategory } from "../../http/get-by-category";

function sleep() {
  return new Promise((resolve) => setTimeout(resolve, 1000));
}

export default function MovieList() {
  const [movies, setMovies] = useState([]);
  const [horrorMovies, setHorrorMovies] = useState([]);
  const [thrillerMovies, setThrillerMovies] = useState([]);
  const [loading, setIsLoading] = useState(true);
  const [othersLoading, setOthersLoading] = useState(true);
  const [queryValue, setQueryValue] = useState("");
  const [searchTerm, setSearchTerm] = useState("");
  const [page] = useState(1);

  useEffect(() => {
    const fetchData = async () => {
      setIsLoading(true);
      setMovies([]);

      if (searchTerm) {
        const result = await getMovies(searchTerm, page);

        await sleep();

        setMovies(result.movies || []);
        setIsLoading(false);

        return;
      }

      const result = await getFeatured();

      await sleep();

      setMovies(result.movies || []);
      setIsLoading(false);
    };

    fetchData();
  }, [searchTerm, page]);

  useEffect(() => {
    const fetchCategoryMovies = async () => {
      setOthersLoading(true);
      const [horrorQuery, thrillerQuery] = await Promise.all([
        getByCategory(process.env.REACT_APP_HORROR_CATEGORY_ID),
        getByCategory(process.env.REACT_APP_THRILLER_CATEGORY_ID),
      ]);

      setHorrorMovies(horrorQuery.movies);
      setThrillerMovies(thrillerQuery.movies);
      setOthersLoading(false);
    };

    fetchCategoryMovies();
  }, []);

  const handleSearch = () => {
    setSearchTerm(queryValue);
  };

  const handleChange = (value) => {
    setQueryValue(value.target.value);
  };

  const handleKeyPress = (e) => {
    if (e.key === "Enter") {
      setSearchTerm(queryValue);
    }
  };

  return (
    <Grid
      container
      spacing={2}
      justifyContent="center"
      className="srv srv--movie-list"
    >
      <Grid item xs={12}>
        <h1 className="srv srv--movie-list-header">Movie List</h1>
      </Grid>
      <SearchBox
        handleSearch={handleSearch}
        handleChange={handleChange}
        handleKeyPress={handleKeyPress}
        queryValue={queryValue}
      />
      {/* Loading state */}
      {loading && <BusyIndicator />}

      {/* No data state */}
      {!loading && movies.length === 0 && (
        <Grid item xs={12}>
          <Stack direction="column" alignItems="center">
            <NoMovie className="srv srv--movie-icon" />
            <h2 className="srv srv--no-movie">
              We didn't found any movie matching "{searchTerm}"
            </h2>
          </Stack>
        </Grid>
      )}
      {/* Featured & Search Results */}
      <MovieRow
        loading={loading && othersLoading}
        movies={movies}
        title={
          searchTerm ? `Search results for "${searchTerm}"` : "Featured Movies"
        }
      />
      <MovieRow
        loading={loading && othersLoading}
        movies={horrorMovies}
        idxBump={2}
        title="Horror"
      />
      <MovieRow
        loading={loading && othersLoading}
        movies={thrillerMovies}
        idxBump={30}
        title="Thriller"
      />
    </Grid>
  );
}
