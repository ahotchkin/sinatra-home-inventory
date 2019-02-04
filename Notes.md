Application Summary

My Sinatra Home Inventory application will allow users to track their home inventory. A user will be able to create an account, add items to their home inventory, and view those items. An item will belong to a category so a user will be able to see all items at one time, as well as just those items in a particular category. A user will only ever see the items they create. They will also be able to update and delete those items, as needed.

Models:
1. User
2. Item

Potential Additional Models:
3. Condition
4. Category

Relationships:
1. A user has many items
2. An item belongs to a user

Potential Additional Relationships:
3. An item belongs to a condition (new, slightly used, used)
4. An item has many categories (how could I do sub-categories?)
5. A user has many conditions through items
6. A user has many categories through items (would require joins table)

Model Validations:
- A user validates presence of a username, email, and password
- An item validates presence of a name and a cost

Potential Additional Model Validations:
- A condition validates presence of a name
- A category validates presence of a name
