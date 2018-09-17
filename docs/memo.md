# Memo

## Create datas...

```
# with no dependent

patient  = Patient.create!
detail   = InspectionDetail.create!
employee = Employee.create!

# set / create relation

order = patient.orders.create!

# create inspection with detail

inspection = order.inspections.create!(inspection_detail: detail)

# create sample of inspection

inspection.create_sample!

# add sample collecter of inspection

inspection.collected_by = employee

# add sender of inspection

inspection.sent_by = employee
```

## Refs

- [RailsGuide association](https://railsguides.jp/association_basics.html)
- [RailsGuide routing](https://railsguides.jp/routing.html)
- [RaisGuide migration](https://railsguides.jp/active_record_migrations.html)
- [検査項目解説](http://data.medience.co.jp/compendium/)
