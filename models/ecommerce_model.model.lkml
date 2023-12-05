connection: "bigquery_ecommerce"

# include all the views
include: "/views/*.view"
include: "/z_tests/*.lkml"

datagroup: training_ecommerce_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: training_ecommerce_default_datagroup

label: "E-Commerce "

explore: ecomm_order_items {
  join: ecomm_users {
    type: left_outer
    sql_on: ${ecomm_order_items.user_id} = ${ecomm_users.id} ;;
    relationship: many_to_one
  }

  join: ecomm_inventory_items {
    type: left_outer
    sql_on: ${ecomm_order_items.inventory_item_id} = ${ecomm_inventory_items.id} ;;
    relationship: many_to_one
  }

  join: ecomm_products {
    type: left_outer
    sql_on: ${ecomm_inventory_items.product_id} = ${ecomm_products.id} ;;
    relationship: many_to_one
  }

  join: ecomm_distribution_centres {
    type: left_outer
    sql_on: ${ecomm_products.distribution_center_id} = ${ecomm_distribution_centres.id} ;;
    relationship: many_to_one
  }
}

explore: ecomm_events {
  join: event_session_facts {
    type: left_outer
    sql_on: ${ecomm_events.session_id} = ${event_session_facts.session_id} ;;
    relationship: many_to_one
  }
  join: event_session_funnel {
    type: left_outer
    sql_on: ${ecomm_events.session_id} = ${event_session_funnel.session_id} ;;
    relationship: many_to_one
  }
  join: ecomm_users {
    type: left_outer
    sql_on: ${ecomm_events.user_id} = ${ecomm_users.id} ;;
    relationship: many_to_one
  }
}
