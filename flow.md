### Call API

1. Add **response** in **lib/data/response**
2. In **lib/data/repositories**
   - Add **\[object\]/i\_\[object\]\_repository**
   - Add **\[object\]/\[object\]\_repository**
3. Add **model** in **lib/data/model**
4. In **lib/data/services**
   - Add **\[object\]/i\_\[object\]\_services**
   - Add **\[object\]/\[object\]\_services**
5. Add **i\_\[object\]service** to **bloc** file
6. Inject **repository** to **repository_dependency** file
7. Inject **service** to **service_dependency** file

### Behavior

##### Cooking page

1. Initialize page, call API at first:

- all categories
- get paging ingredients by all categories, classify them into map
  - All: category id = 0
  - Click All, get 10 items by category id = 1
    // check if device is not connect internet
- save them into local storage to use offline

2. Load more:

- get paging ingredients by all categories with page index

3. Click another category:

- Check if the category existes in map
  - F: call API get paginated ingredients by all categories
  - T: get the first page index ingredients from map for the specified category
