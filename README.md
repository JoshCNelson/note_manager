# Note Management System

### To start locally
- `bundle install`
- `rails db:migrate`
- `rails server`

### Notes and Assumptions
- For accessing notes I intentionally chose not to nest the resource under users (e.g. `/users/:user_id/notes`). My thought process was that the notes dashboard appear to be more for private usage and that exposing that as a route was not optimal. If there was discussion about opening up the possibility of a user visiting another user's notes dashboard then this decision would need to be revisited.

- I tried to keep the interface as minimalist and clean as possible while still looking reasonably pleasant.

- For testing, I did some pretty comprehensive controller testing as I figured that was where I would get the most bang for my buck. If time permits, I may add some end to end testing with capybara as having a few happy path end to end tests is always valuable.