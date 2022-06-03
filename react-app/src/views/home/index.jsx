import React from "react";
import Grid from "@mui/material/Grid";
import Stack from "@mui/material/Stack";
import Button from "@mui/material/Button";
import { ReactComponent as MovieIcon } from "../../icons/movie.svg";
import { useNavigate } from "react-router-dom";
import "./style.scss";

function Home() {
  const navigate = useNavigate();

  return (
    <Grid
      container
      spacing={2}
      justifyContent="center"
      className="srv srv--home-page"
    >
      <Grid item xs={12}>
        <MovieIcon className="srv srv--home-logo" />
      </Grid>
      <Grid item xs={12}>
        <h1 className="srv srv--title">Movie Search Tool</h1>
      </Grid>
      <Grid item xs={12} className="srv srv--desc-wrap">
        <p className="srv srv--desc">
          Search movies without getting bombarded with advertisements
        </p>
      </Grid>
      <Grid item xs={12}>
        <Stack alignItems="center">
          <Button
            variant="contained"
            disableElevation
            className="srv srv--start-button"
            onClick={() => navigate("/movies")}
          >
            Let's Go!!
          </Button>
        </Stack>
      </Grid>
    </Grid>
  );
}

export default Home;
