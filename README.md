# README

<img width="874" alt="Screen Shot 2022-01-14 at 7 49 37 AM" src="https://user-images.githubusercontent.com/58535045/149547086-11afe699-9191-4432-a7a4-616d92c99ef2.png">

### Built With
#### Framework
<p>
  <img src="https://img.shields.io/badge/Ruby%20On%20Rails-b81818.svg?&style=flat&logo=rubyonrails&logoColor=white" />
</p>

#### Tools
<p>
  <img src="https://img.shields.io/badge/VS_Code-007ACC?logo=visual%20studio%20code&logoColor=ffffff" />
  <img src="https://img.shields.io/badge/Git-F05032.svg?&style=flaste&logo=git&logoColor=white" />
  <img src="https://img.shields.io/badge/GitHub-181717.svg?&style=flaste&logo=github&logoColor=white" />
  <img src="https://img.shields.io/badge/PostgreSQL-4169E1.svg?&style=flaste&logo=postgresql&logoColor=white" />
</p>

#### Gems
<p>
  <img src="https://img.shields.io/badge/rspec-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/pry-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />  
  <img src="https://img.shields.io/badge/simplecov-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />  
  <img src="https://img.shields.io/badge/faker-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/rubocop-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/shoulda--matchers-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/factory--bot-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/json_api_serializer-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
</p>

#### Development Principles
<p>
  <img src="https://img.shields.io/badge/OOP-b81818.svg?&style=flaste&logo=OOP&logoColor=white" />
  <img src="https://img.shields.io/badge/TDD-b87818.svg?&style=flaste&logo=TDD&logoColor=white" />
  <img src="https://img.shields.io/badge/REST-33b818.svg?&style=flaste&logo=REST&logoColor=white" />
</p>

- <p><b>GET /api/v1/teas</b></p>
```json
{
  "data": [
    {
      "id": "1",
      "type": "tea",
      "attributes": {
        "name": "Cerasse",
        "description": "In harum fugiat temporibus.",
        "temperature": 186,
        "brew_time": 3
      }
    },
    {
      "id": "2",
      "type": "tea",
      "attributes": {
        "name": "Rougui",
        "description": "Qui molestiae dolorum repudiandae.",
        "temperature": 153,
        "brew_time": 5
      }
    }
  ]
}
```

- <p><b>GET /api/v1/teas/1</b></p>
```json
{
  "data": {
    "id": "1",
    "type": "tea",
    "attributes": {
      "name": "Cerasse",
      "description": "In harum fugiat temporibus.",
      "temperature": 186,
      "brew_time": 3
    }
  }
}
```

- <p><b>GET /api/v1/customers</b></p>
```json
{
  "data": [
    {
      "id": "1",
      "type": "customer",
      "attributes": {
        "first_name": "Lenard",
        "last_name": "Torp",
        "email": "lenardtorp@mail.com",
        "address": "76547 Bauch Streets, South Michaele, IN 02949-7386"
      }
    },
    {
      "id": "2",
      "type": "customer",
      "attributes": {
        "first_name": "Bill",
        "last_name": "Ruecker",
        "email": "billruecker@mail.com",
        "address": "176 Gutkowski Oval, North Deweychester, AR 29498-1317"
      }
    }
  ]
}
```

- <p><b>GET /api/v1/customers/1</b></p>
```json
{
  "data": {
    "id": "1",
    "type": "customer",
    "attributes": {
      "first_name": "Lenard",
      "last_name": "Torp",
      "email": "lenardtorp@mail.com",
      "address": "76547 Bauch Streets, South Michaele, IN 02949-7386"
    }
  }
}
```

- <p><b>POST /api/v1/customers/1/subscriptions/1</b></p>
```json
{
  "data": {
    "id": "3",
    "type": "subscription",
    "attributes": {
      "title": "Cerasse Subscription",
      "price": 4.99,
      "status": "active",
      "frequency": "2",
      "tea_id": 1,
      "customer_id": 1
    }
  }
}
```

- <p><b>PATCH /api/v1/customers/1/subscriptions/1</b></p>
```json
{
  "data": {
    "id": "3",
    "type": "subscription",
    "attributes": {
      "title": "Cerasse Subscription",
      "price": 4.99,
      "status": "cancelled",
      "frequency": "2",
      "tea_id": 1,
      "customer_id": 1
    }
  }
}
```

- <p><b>GET /api/v1/customers/1/subscriptions</b></p>
```json
{
  "data": [
    {
      "id": "1",
      "type": "subscription",
      "attributes": {
        "title": "Cerasse Subscription",
        "price": 4.99,
        "status": "cancelled",
        "frequency": "2",
        "tea_id": 1,
        "customer_id": 1
      }
    },
    {
      "id": "2",
      "type": "subscription",
      "attributes": {
        "title": "Cerasse Subscription",
        "price": 4.99,
        "status": "cancelled",
        "frequency": "2",
        "tea_id": 1,
        "customer_id": 1
      }
    }
  ]
}
```

- <p><b>GET /api/v1/customers/1/subscriptions/1</b></p>
```json
{
  "data": [
    {
      "id": "1",
      "type": "subscription",
      "attributes": {
        "title": "Cerasse Subscription",
        "price": 4.99,
        "status": "cancelled",
        "frequency": "2",
        "tea_id": 1,
        "customer_id": 1
      }
    }
  ]
}
```