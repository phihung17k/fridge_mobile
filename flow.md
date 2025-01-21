### Call API

1. Add **response** in **lib/data/response**
2. In **lib/data/repositories**
   - Add **\[object\]/i\_\[object\]\_repository**
   - Add **\[object\]/\[object\]\_repository**
3. Add **model** in **lib/data/model**
4. In **lib/data/services**
   - Add **\[object\]/i\_\[object\]\_services**
   - Add **\[object\]/\[object\]\_services**
5. Add **i_\[object\]service** to **bloc** file
6. Inject **repository** to **repository_dependency** file
7. Inject **service** to **service_dependency** file
