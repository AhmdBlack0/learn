# Complete MongoDB Commands Reference

## Database Operations

### Database Management
``` js

// Show all databases
show dbs

// Switch to/create database
use database_name

// Show current database
db

// Drop current database
db.dropDatabase()

// Get database stats
db.stats()

// List collections in current database
show collections
db.listCollections()
```

## Collection Operations

### Collection Management
```javascript
// Create collection
db.createCollection("collection_name")
db.createCollection("collection_name", {capped: true, size: 100000})

// Drop collection
db.collection_name.drop()

// Rename collection
db.collection_name.renameCollection("new_name")

// Get collection stats
db.collection_name.stats()

// Validate collection
db.collection_name.validate()
```

## CRUD Operations

### Create (Insert)
```javascript
// Insert one document
db.collection.insertOne({field1: "value1", field2: "value2"})

// Insert multiple documents
db.collection.insertMany([
    {field1: "value1", field2: "value2"},
    {field1: "value3", field2: "value4"}
])

// Insert (legacy)
db.collection.insert({field1: "value1"})
db.collection.save({field1: "value1"}) // Insert or update
```

### Read (Query)
```javascript
// Find all documents
db.collection.find()

// Find with conditions
db.collection.find({field1: "value1"})

// Find one document
db.collection.findOne({field1: "value1"})

// Find with projection
db.collection.find({}, {field1: 1, field2: 1, _id: 0})

// Count documents
db.collection.countDocuments()
db.collection.countDocuments({field1: "value1"})

// Distinct values
db.collection.distinct("field_name")

// Limit and skip
db.collection.find().limit(10)
db.collection.find().skip(5).limit(10)

// Sort
db.collection.find().sort({field1: 1}) // 1 for ascending, -1 for descending

// Pretty print
db.collection.find().pretty()
```

### Update
```javascript
// Update one document
db.collection.updateOne(
    {field1: "value1"}, 
    {$set: {field2: "new_value"}}
)

// Update many documents
db.collection.updateMany(
    {field1: "value1"}, 
    {$set: {field2: "new_value"}}
)

// Replace one document
db.collection.replaceOne(
    {field1: "value1"}, 
    {field1: "value1", field2: "new_value"}
)

// Find and update
db.collection.findOneAndUpdate(
    {field1: "value1"}, 
    {$set: {field2: "new_value"}},
    {returnNewDocument: true}
)

// Upsert (update or insert)
db.collection.updateOne(
    {field1: "value1"}, 
    {$set: {field2: "new_value"}},
    {upsert: true}
)

// Legacy update
db.collection.update({field1: "value1"}, {$set: {field2: "new_value"}})
```

### Delete
```javascript
// Delete one document
db.collection.deleteOne({field1: "value1"})

// Delete many documents
db.collection.deleteMany({field1: "value1"})

// Find and delete
db.collection.findOneAndDelete({field1: "value1"})

// Remove all documents
db.collection.deleteMany({})

// Legacy remove
db.collection.remove({field1: "value1"})
```

## Query Operators

### Comparison Operators
```javascript
// Equal to
db.collection.find({field: {$eq: "value"}})
db.collection.find({field: "value"}) // Shorthand

// Not equal to
db.collection.find({field: {$ne: "value"}})

// Greater than
db.collection.find({field: {$gt: 10}})

// Greater than or equal to
db.collection.find({field: {$gte: 10}})

// Less than
db.collection.find({field: {$lt: 10}})

// Less than or equal to
db.collection.find({field: {$lte: 10}})

// In array
db.collection.find({field: {$in: ["value1", "value2"]}})

// Not in array
db.collection.find({field: {$nin: ["value1", "value2"]}})
```

### Logical Operators
```javascript
// AND (implicit)
db.collection.find({field1: "value1", field2: "value2"})

// AND (explicit)
db.collection.find({$and: [{field1: "value1"}, {field2: "value2"}]})

// OR
db.collection.find({$or: [{field1: "value1"}, {field2: "value2"}]})

// NOT
db.collection.find({field: {$not: {$gt: 10}}})

// NOR
db.collection.find({$nor: [{field1: "value1"}, {field2: "value2"}]})
```

### Element Operators
```javascript
// Field exists
db.collection.find({field: {$exists: true}})

// Type check
db.collection.find({field: {$type: "string"}})
db.collection.find({field: {$type: 2}}) // String type number
```

### Array Operators
```javascript
// All elements match
db.collection.find({array_field: {$all: ["value1", "value2"]}})

// Array size
db.collection.find({array_field: {$size: 3}})

// Element match
db.collection.find({array_field: {$elemMatch: {field1: "value1", field2: {$gt: 10}}}})
```

### Regex and Text
```javascript
// Regular expression
db.collection.find({field: {$regex: /pattern/i}})
db.collection.find({field: {$regex: "pattern", $options: "i"}})

// Text search (requires text index)
db.collection.find({$text: {$search: "search terms"}})
```

## Update Operators

### Field Update Operators
```javascript
// Set field value
{$set: {field: "value"}}

// Unset (remove) field
{$unset: {field: ""}}

// Rename field
{$rename: {old_name: "new_name"}}

// Increment numeric value
{$inc: {counter: 1}}

// Multiply numeric value
{$mul: {price: 1.1}}

// Set minimum value
{$min: {score: 100}}

// Set maximum value
{$max: {score: 100}}

// Set current date
{$currentDate: {lastModified: true}}
{$currentDate: {lastModified: {$type: "timestamp"}}}
```

### Array Update Operators
```javascript
// Add to array
{$push: {array_field: "new_value"}}

// Add multiple to array
{$push: {array_field: {$each: ["value1", "value2"]}}}

// Add to array if not exists
{$addToSet: {array_field: "new_value"}}

// Remove from array
{$pull: {array_field: "value_to_remove"}}
{$pull: {array_field: {$gt: 10}}}

// Remove multiple from array
{$pullAll: {array_field: ["value1", "value2"]}}

// Remove first/last element
{$pop: {array_field: 1}}  // Remove last
{$pop: {array_field: -1}} // Remove first

// Update array element by position
{$set: {"array_field.0": "new_value"}}

// Update array element by condition
{$set: {"array_field.$": "new_value"}} // Use with array query
```

## Aggregation Pipeline

### Basic Pipeline Operations
```javascript
// Basic aggregation
db.collection.aggregate([
    {$match: {field: "value"}},
    {$group: {_id: "$category", count: {$sum: 1}}},
    {$sort: {count: -1}}
])

// Match stage (filter)
{$match: {field: "value"}}

// Project stage (select fields)
{$project: {field1: 1, field2: 1, _id: 0}}
{$project: {fullName: {$concat: ["$firstName", " ", "$lastName"]}}}

// Group stage
{$group: {
    _id: "$category",
    count: {$sum: 1},
    average: {$avg: "$price"},
    total: {$sum: "$amount"}
}}

// Sort stage
{$sort: {field: 1}} // 1 for ascending, -1 for descending

// Limit stage
{$limit: 10}

// Skip stage
{$skip: 5}

// Unwind stage (flatten arrays)
{$unwind: "$array_field"}

// Lookup stage (join)
{$lookup: {
    from: "other_collection",
    localField: "local_field",
    foreignField: "foreign_field",
    as: "joined_data"
}}

// Add fields
{$addFields: {newField: {$add: ["$field1", "$field2"]}}}

// Replace root
{$replaceRoot: {newRoot: "$nested_object"}}

// Count
{$count: "total_count"}
```

### Aggregation Operators
```javascript
// Arithmetic
{$add: ["$field1", "$field2"]}
{$subtract: ["$field1", "$field2"]}
{$multiply: ["$field1", "$field2"]}
{$divide: ["$field1", "$field2"]}

// String operations
{$concat: ["$firstName", " ", "$lastName"]}
{$substr: ["$field", 0, 3]}
{$toUpper: "$field"}
{$toLower: "$field"}

// Date operations
{$year: "$date_field"}
{$month: "$date_field"}
{$dayOfMonth: "$date_field"}

// Array operations
{$size: "$array_field"}
{$arrayElemAt: ["$array_field", 0]}

// Conditional
{$cond: {if: {$gt: ["$field", 10]}, then: "high", else: "low"}}
```

## Index Operations

### Index Management
```javascript
// Create index
db.collection.createIndex({field: 1}) // 1 for ascending, -1 for descending
db.collection.createIndex({field1: 1, field2: -1}) // Compound index

// Create unique index
db.collection.createIndex({field: 1}, {unique: true})

// Create sparse index
db.collection.createIndex({field: 1}, {sparse: true})

// Create partial index
db.collection.createIndex(
    {field: 1}, 
    {partialFilterExpression: {field: {$exists: true}}}
)

// Create text index
db.collection.createIndex({field: "text"})
db.collection.createIndex({field1: "text", field2: "text"}) // Multiple fields

// Create 2dsphere index (for geospatial)
db.collection.createIndex({location: "2dsphere"})

// List indexes
db.collection.getIndexes()

// Drop index
db.collection.dropIndex({field: 1})
db.collection.dropIndex("index_name")

// Drop all indexes
db.collection.dropIndexes()

// Reindex collection
db.collection.reIndex()

// Get index stats
db.collection.stats({indexDetails: true})
```

## Administrative Commands

### User Management
```javascript
// Create user
db.createUser({
    user: "username",
    pwd: "password",
    roles: ["readWrite"]
})

// Drop user
db.dropUser("username")

// Update user
db.updateUser("username", {roles: ["read"]})

// List users
db.getUsers()

// Authenticate
db.auth("username", "password")

// Change user password
db.changeUserPassword("username", "new_password")
```

### Server Status and Maintenance
```javascript
// Server status
db.serverStatus()

// Database stats
db.stats()

// Current operations
db.currentOp()

// Kill operation
db.killOp(operation_id)

// Repair database
db.repairDatabase()

// Compact collection
db.runCommand({compact: "collection_name"})

// Get profiler status
db.getProfilingStatus()

// Set profiler level
db.setProfilingLevel(2) // 0=off, 1=slow ops, 2=all ops

// Profiler data
db.system.profile.find()

// Host info
db.hostInfo()

// Build info
db.version()
db.buildInfo()
```

## Replica Set Commands

```javascript
// Initialize replica set
rs.initiate()

// Add member
rs.add("hostname:port")

// Remove member
rs.remove("hostname:port")

// Get replica set status
rs.status()

// Get replica set configuration
rs.conf()

// Reconfigure replica set
rs.reconfig(config)

// Step down primary
rs.stepDown()

// Force member to be primary
rs.freeze(0)
```

## Sharding Commands

```javascript
// Enable sharding on database
sh.enableSharding("database_name")

// Shard collection
sh.shardCollection("database.collection", {shard_key: 1})

// Get sharding status
sh.status()

// List shards
sh.listShards()

// Add shard
sh.addShard("hostname:port")

// Remove shard
db.runCommand({removeShard: "shard_name"})

// Move chunk
sh.moveChunk("database.collection", {shard_key: "value"}, "target_shard")

// Split chunk
sh.splitAt("database.collection", {shard_key: "split_value"})
```

## Utilities and Helpers

```javascript
// Help commands
help
db.help()
db.collection.help()

// Exit MongoDB shell
exit
quit()

// Load JavaScript file
load("script.js")

// Print without formatting
print("message")
printjson(object)

// Date operations
new Date()
ISODate("2023-01-01")

// ObjectId operations
ObjectId()
ObjectId("hex_string")

// Random data
Math.random()
```

## Advanced Queries

### Geospatial Queries
```javascript
// Near query (requires 2dsphere index)
db.collection.find({
    location: {
        $near: {
            $geometry: {type: "Point", coordinates: [longitude, latitude]},
            $maxDistance: 1000
        }
    }
})

// Within polygon
db.collection.find({
    location: {
        $geoWithin: {
            $geometry: {
                type: "Polygon",
                coordinates: [[[x1, y1], [x2, y2], [x3, y3], [x1, y1]]]
            }
        }
    }
})
```

### GridFS (File Storage)
```javascript
// Put file (using mongofiles utility)
mongofiles put filename

// Get file
mongofiles get filename

// List files
mongofiles list

// Delete file
mongofiles delete filename
