import React, { useRef } from "react";
// Style
import "./style.scss";
// MUI components
import Grid from "@mui/material/Grid";
import Fab from "@mui/material/Fab";
import ArrowBack from "@mui/icons-material/ArrowBack";
import ArrowForward from "@mui/icons-material/ArrowForward";
// Custom Components
import MovieCard from "../movie-card";
// const
const SCROLL_OFFSET = 900;

export default function MovieRow({
  loading,
  movies,
  idxBump = 0,
  title = "Featured",
}) {
  const scrollRef = useRef(null);

  const scroll = (scrollOffset, duration = 250) => {
    let start = scrollRef.current.scrollLeft;
    let currentTime = 0;
    let increment = 20;

    function easeInOutQuad(t, b, c, d) {
      t /= d / 2;
      if (t < 1) return (c / 2) * t * t + b;
      t--;
      return (-c / 2) * (t * (t - 2) - 1) + b;
    }

    const animateScroll = function () {
      currentTime += increment;
      const val = easeInOutQuad(currentTime, start, scrollOffset, duration);
      scrollRef.current.scrollLeft = val;

      if (currentTime < duration) {
        setTimeout(animateScroll, increment);
      }
    };

    animateScroll();
  };

  return (
    <>
      {!loading && movies && movies.length > 0 && (
        <Grid item xs={12}>
          <h4 className="srv srv--title">{title}</h4>
        </Grid>
      )}
      {/* Poster Row */}
      <Grid item container xs={12} className="srv srv--poster-row">
        {!loading && movies && movies.length > 0 && (
          <Fab
            color="primary"
            size="small"
            className="srv srv--back"
            onClick={() => scroll(SCROLL_OFFSET * -1)}
          >
            <ArrowBack />
          </Fab>
        )}
        <Grid
          item
          container
          xs={12}
          className="srv srv--poster-wrap"
          ref={scrollRef}
        >
          {!loading &&
            movies.length > 0 &&
            movies.map((movie, index) => {
              return (
                <MovieCard
                  movie={movie}
                  index={index}
                  key={`${idxBump}-${index}`}
                />
              );
            })}
        </Grid>
        {!loading && movies && movies.length > 0 && (
          <Fab
            color="primary"
            size="small"
            className="srv srv--forward"
            onClick={() => scroll(SCROLL_OFFSET)}
          >
            <ArrowForward />
          </Fab>
        )}
      </Grid>
    </>
  );
}
