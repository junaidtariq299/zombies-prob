# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Survivor.create({name: 'John', age: 30, gender: 'male', latitude: 27.2038, longitude: 77.5011 })
Survivor.create({name: 'Ammanda', age: 28, gender: 'female', latitude: 28.2038, longitude: 76.5011 })
Item.create([{name:'Fiji Water',points: 14},{name:'Campbell Soup',points: 12},{name:'First Aid Pouch',points: 10},{name:'AK47',points: 8}])
Survivor.find(1).inventory_items=[InventoryItem.create(item_id: 1, quantity: 10),InventoryItem.create(item_id: 2, quantity: 3)]
Survivor.find(2).inventory_items=[InventoryItem.create(item_id: 2, quantity: 20),InventoryItem.create(item_id: 3, quantity: 6)]