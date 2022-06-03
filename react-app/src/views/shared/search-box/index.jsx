import React from "react";
import Grid from "@mui/material/Grid";
import Stack from "@mui/material/Stack";
import FilledInput from "@mui/material/FilledInput";
import FormControl from "@mui/material/FormControl";
import InputLabel from "@mui/material/InputLabel";
import InputAdornment from "@mui/material/InputAdornment";
import IconButton from "@mui/material/IconButton";
import Search from "@mui/icons-material/Search";
import "./style.scss";
import { TEXT_COLOR, BG_COLOR } from "../../../styles/styles";

function SearchBox({ handleSearch, handleChange, handleKeyPress, queryValue }) {
  return (
    <Grid item xs={12}>
      <Stack className="srv srv--search-wrap">
        <FormControl variant="filled" sx={{ backgroundColor: BG_COLOR }}>
          <InputLabel
            className="srv srv--search-label"
            htmlFor="filled-adornment-password"
          >
            Search by title...
          </InputLabel>
          <FilledInput
            className="srv srv--search-box"
            autoFocus
            sx={{
              input: {
                color: TEXT_COLOR,
              },
            }}
            endAdornment={
              <InputAdornment
                sx={{
                  color: TEXT_COLOR,
                  paddingRight: "4px",
                }}
                position="end"
              >
                <IconButton
                  sx={{
                    color: TEXT_COLOR,
                  }}
                  onClick={handleSearch}
                  onMouseDown={handleSearch}
                  edge="end"
                >
                  <Search />
                </IconButton>
              </InputAdornment>
            }
            value={queryValue}
            onChange={handleChange}
            onKeyPress={handleKeyPress}
          />
        </FormControl>
      </Stack>
    </Grid>
  );
}

export default SearchBox;
