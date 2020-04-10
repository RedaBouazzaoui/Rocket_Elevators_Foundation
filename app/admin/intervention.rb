ActiveAdmin.register Intervention do
  
    index do
      selectable_column
      id_column
      column  :author
      column  :employee_id
      column  :building_id
      column  :battery_id
      column  :column_id
      column  :elevator_id
      column  :rapport
      column  :resultat
      column  :status
      Column  :start_intervention
      Column  :end_intervention
      
      actions
    end
  
    filter :author
    filter :employee_id
    
  end