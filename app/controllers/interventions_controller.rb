class InterventionsController < ApplicationController
    #  before_action :set_intervention, only: [:show, :edit, :update, :destroy]
    # before_action :authenticate_user!
  
    # GET /quotes.json
    def index
      # @interventions = Intervention.all
    end
  
    # Method to get buildings related to a selected customer
    def get_building
        if params[:customer].present?
            @buildings = Customer.find(params[:customer]).buildings
        else
            @buildings = Customer.all
        end
        if request.xhr?
            respond_to do |format|
                format.json {
                    render json: {buildings: @buildings}
                }
            end
        end
    end

    # Method to get batteries related to a selected building
    def get_battery
        if params[:building].present?
            @batteries = Building.find(params[:building]).batteries
        else
            @batteries = Building.all
        end
        if request.xhr?
            respond_to do |format|
                format.json {
                    render json: {batteries: @batteries}
                }
            end
        end
    end

    # Method to get columnns related to a selected battery
    def get_column
        if params[:battery].present?
            @columns = Battery.find(params[:battery]).columns
        else
            @columns = Battery.all
        end
        if request.xhr?
            respond_to do |format|
                format.json {
                    render json: {columns: @columns}
                }
            end
        end
    end

    # Method to get elevators related to a selected column
    def get_elevator
        if params[:column].present?
            @elevators = Column.find(params[:column]).elevators
        else
            @elevators = Column.all
        end
        if request.xhr?
            respond_to do |format|
                format.json {
                    render json: {elevators: @elevators}
                }
            end
        end
    end
    # # GET /interventions/1.json
    # def show
    # end
  
    # GET /interventions/new
    def new
      @intervention = Intervention.new
    end
  
    # # GET /interventions/1/edit
    # def edit
    # end
    

    # The create method contains the variable declarations used in the Zendesk API, and the controller actions after
    # a user has submitted an intervention
    def create
      
      @intervention = Intervention.new(intervention_params)

        # # Variables needed and used in the Zendesk API message
        @intervention.author = current_employee.id
        author_firstname = current_employee.first_name
        author_lastname = current_employee.last_name
        customer_company = Customer.find(params[:customer]).company_name

        # # Rule to avoid an error message if no employee is selected
        if @intervention.employee_id != nil
        @employee_fname = Employee.find(params[:employee]).first_name
        @employee_lname = User.find(params[:employee]).last_name

         added_details = "(#{@employee_fname} #{@employee_lname} was asked to answer this ticket)"
        else
            added_details = ""
        end

        # Content from the intervention form
        @intervention.employee_id = params[:employee]
        @intervention.customer_id = params[:customer]
        @intervention.building_id = params[:building]
        @intervention.battery_id = params[:battery]
        @intervention.column_id = params[:column]
        @intervention.elevator_id = params[:elevator]
        @intervention.resultat = "Incomple"
        @intervention.rapport = params[:report]
        @intervention.status = "Pending"
      
    #==================================== Zendesk API session =============================================#  
      # Create a personalized ticket 
      ZendeskAPI::Ticket.create!(@client, 
        :subject => "Intervention ticket from employee ##{@intervention.author} - #{author_firstname} #{author_lastname} - Rocket Elevators",
        :requester => {"name": @current_employee.email},
        :comment => { :value => "Employee #{@intervention.author} (#{author_firstname} #{author_lastname}) working for customer #{@intervention.customer_id} (#{@customer_company}) on building  #{@intervention.building_id}, battery #{@intervention.battery_id}, column #{@intervention.column_id} and elevator #{@intervention.elevator_id} has dispatched an employee (#{@intervention.employee_id}) to answer the present ticket.
        *** An element with no value after a '#' means no specific element has been selected on the form ***
        Here is a description of the intervention to be made : 
        #{@intervention.rapport}  
        #{added_details}
        "}, 
        :submitter_id => @intervention.author,
        :type => "problem",
        :priority => "urgent")

      
    #==================================== END Zendesk API session =========================================# 
  
      respond_to do |format|
        if @intervention.save!
          format.html { redirect_to "/interventions" }
          format.json { render :show, status: :created, location: @intervention }
          p @intervention
          p "coucou"
        else
          format.html { redirect_to "/interventions" }
          format.json { render json: @intervention.errors, status: :unprocessable_entity }
          p "wo menute"
        end
      end
    end
  
   
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def intervention_params
        params.permit( :employee_id, :customer_id, :building_id, :battery_id, :column_id, :elevator_id, :resultat, :rapport, :status)
      end
  end