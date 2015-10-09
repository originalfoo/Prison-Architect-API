
function CreateGrants()

	CreateBootstrapGrants();
	CreateFirstCellBlockGrant();
	CreateHealthGrant();
    CreateMaintenanceGrant();
    CreatePrisonerVisitationGrant();
    CreateBasicSecurityGrant();
    CreateEnhancedSecurityGrant();
    CreateAdvancedSecurityGrant();
    CreatePrisonerWorkforceGrant();
    CreateEducationReformGrant();
    CreateBailout();
    CreatePrisonLabourGrant();
    CreateFurnitureManufacturingGrant();
    
    CreateReduceStaffStressGrant();
    CreateNutritionResearchGrant();
    CreateDrugSearchGrant();
    CreateContrabandSupplyGrant();
    
    CreateShortTermInvestment();
    CreateLongTermInvestment();
    
    CreateCellBlockGrant( 50, -1 )
    CreateCellBlockGrant( 100, 50 )
    CreateCellBlockGrant( 200, 100 )
    CreateCellBlockGrant( 500, 200 )
   
    
end



function CreateBootstrapGrants()

	-- Basic Detention Centre
	
	Objective.CreateGrant			( "Grant_bootstraps", 20000, 10000 )
	
	Objective.CreateGrant			( "Grant_bootstraps_holdingcell", 0, 0 )	
	Objective.SetParent				( "Grant_bootstraps" )
	Objective.RequireRoom			( "HoldingCell", true )
	
	Objective.CreateGrant			( "Grant_bootstraps_shower", 0, 0 )	
	Objective.SetParent				( "Grant_bootstraps" )
	Objective.RequireRoom			( "Shower", true )
	
	Objective.CreateGrant			( "Grant_bootstraps_yard", 0, 0 )
	Objective.SetParent				( "Grant_bootstraps" )
	Objective.RequireRoom			( "Yard", true )

	Objective.CreateGrant			( "Grant_bootstraps_kitchen", 0, 0 )
	Objective.SetParent				( "Grant_bootstraps" )
	Objective.RequireRoom			( "Kitchen", true )
	
	Objective.CreateGrant			( "Grant_bootstraps_canteen", 0, 0 )
	Objective.SetParent				( "Grant_bootstraps" )
	Objective.RequireRoom			( "Canteen", true )

	Objective.CreateGrant			( "Grant_bootstraps_guard", 0, 0 )
	Objective.SetParent				( "Grant_bootstraps" )
	Objective.RequireObjects		( "Guard", 2 )

	Objective.CreateGrant			( "Grant_bootstraps_chef", 0, 0 )
	Objective.SetParent				( "Grant_bootstraps" )
	Objective.RequireObjects		( "Cook", 2 )

	
	-- Basic Administrative set up
	
	Objective.CreateGrant			( "Grant_Administration", 5000, 5000 )
	
	Objective.CreateGrant			( "Grant_Administration_offices", 0, 0 )
	Objective.SetParent				( "Grant_Administration" )
	Objective.RequireRoomsAvailable	( "Office", 2 )
	
	Objective.CreateGrant			( "Grant_Administration_Warden", 0, 0 )
	Objective.SetParent				( "Grant_Administration" )
	Objective.RequireObjects		( "Warden", 1 )
	
	Objective.CreateGrant			( "Grant_Administration_Accountant_Research", 0, 0 )
	Objective.SetParent				( "Grant_Administration" )
	Objective.RequireResearched		( "Finance" )
	
	Objective.CreateGrant			( "Grant_Administration_Accountant", 0, 0 )
	Objective.SetParent				( "Grant_Administration" )
	Objective.RequireObjects		( "Accountant", 1 )
	
end



function CreateFirstCellBlockGrant()

	Objective.CreateGrant			( "Grant_FirstCellBlock", 20000, 20000 )
    Objective.SetPreRequisite       ( "Completed", "Grant_bootstraps", 0 )
    Objective.SetPreRequisite       ( "Unlocked", "Finance", 0 )

	Objective.CreateGrant			( "Grant_FirstCellBlock_Cells", 0, 0 )
	Objective.SetParent				( "Grant_FirstCellBlock" )	
	Objective.RequirePrisonerCapacity(15)
	
end

function CreateCellBlockGrant( requiredCells, preReq )
    grantName = "Grant_CellBlock" .. requiredCells
    preReqName = "Grant_CellBlock" .. preReq
    
    if preReq == -1 then
        preReqName = "Grant_FirstCellBlock"
    end
    
    Objective.CreateGrant			( grantName, 10000, 20000 )
    Objective.SetPreRequisite       ( "Completed", preReqName, 1 )
    Objective.HiddenWhileLocked     ()

	Objective.CreateGrant			( grantName .. "_Cells", 0, 0 )
	Objective.SetParent				( grantName )	
	Objective.RequirePrisonerCapacity(requiredCells)
end


function CreateHealthGrant()

	Objective.CreateGrant			( "Grant_Health", 10000, 10000 )
	
	Objective.CreateGrant			( "Grant_Health_Ward", 0, 0 )
	Objective.SetParent				( "Grant_Health" )
	Objective.RequireRoom			( "MedicalWard", true )
	
	Objective.CreateGrant			( "Grant_Health_Doctors", 0, 0 )
	Objective.RequireObjects		( "Doctor", 2 )
	Objective.SetParent				( "Grant_Health" )
	
	Objective.CreateGrant			( "Grant_Health_Psychologist", 0, 0 )
	Objective.RequireObjects		( "Psychologist", 1 )
	Objective.SetParent				( "Grant_Health" )
	
end

function CreateBailout()

    Objective.CreateGrant           ( "Grant_Bailout", 50000, 50000 )
    Objective.SetPreRequisite       ( "Cash", "AtMost", 500 )
    Objective.SetPreRequisite       ( "Cashflow", "AtMost", 0 )
    Objective.SetPreRequisite       ( "Debt", "AtLeast", 10000 )
    Objective.SetPreRequisite       ( "Prisoners", "AtLeast", 30 )
    Objective.HiddenWhileLocked     ()

    Objective.CreateGrant           ( "Grant_Bailout_Cashflow", 0, 0 )
    Objective.SetParent             ( "Grant_Bailout" )
    Objective.Requires              ( "Cashflow", "AtLeast", 100 )
    
    Objective.CreateGrant           ( "Grant_Bailout_Debt", 0, 0 )
    Objective.SetParent             ( "Grant_Bailout" )
    Objective.Requires              ( "Debt", "AtMost", 0 )

end

function CreateMaintenanceGrant()
    Objective.CreateGrant           ( "Grant_Maintenance", 10000, 5000 );
    Objective.SetPreRequisite       ( "Completed", "Grant_bootstraps", 0 )

    Objective.CreateGrant           ( "Grant_Maintenance_Research_Root", 0, 0 )
    Objective.SetParent             ( "Grant_Maintenance" )
    Objective.RequireResearched     ( "Maintainance" )
    
    Objective.CreateGrant           ( "Grant_Maintenance_Research_Cleaning", 0, 0 )
    Objective.SetParent             ( "Grant_Maintenance" )
    Objective.RequireResearched     ( "Cleaning" )
    
    Objective.CreateGrant           ( "Grant_Maintenance_Research_GroundsKeeping", 0, 0 )
    Objective.SetParent             ( "Grant_Maintenance" )
    Objective.RequireResearched     ( "GroundsKeeping" )
    
    Objective.CreateGrant           ( "Grant_Maintenance_Foreman", 0, 0 )
    Objective.SetParent             ( "Grant_Maintenance" )
    Objective.RequireObjects        ( "Foreman", 1 )
    
    Objective.CreateGrant           ( "Grant_Maintenance_Janitor", 0, 0 )
    Objective.SetParent             ( "Grant_Maintenance" )
    Objective.RequireObjects        ( "Janitor", 2 )
    
    Objective.CreateGrant           ( "Grant_Maintenance_Gardener", 0, 0 )
    Objective.SetParent             ( "Grant_Maintenance" )
    Objective.RequireObjects        ( "Gardener", 1 )
end
    
function CreatePrisonerVisitationGrant()
    Objective.CreateGrant           ( "Grant_Visitation", 5000, 5000 )
    Objective.SetPreRequisite       ( "Completed", "Grant_bootstraps", 0 )

    Objective.CreateGrant           ( "Grant_Visitation_Room", 0, 0 )
    Objective.SetParent             ( "Grant_Visitation" )
    Objective.RequireRoom           ( "Visitation", true )
    
    Objective.CreateGrant           ( "Grant_Visitation_Tables", 0 ,0 )
    Objective.SetParent             ( "Grant_Visitation" )
    Objective.RequireObjects        ( "VisitorTable", 3 )
    
    Objective.CreateGrant           ( "Grant_Visitation_CommonRoom", 0, 0 )
    Objective.SetParent             ( "Grant_Visitation" )
    Objective.RequireRoom           ( "CommonRoom", true )
    
    Objective.CreateGrant           ( "Grant_Visitation_PoolTable", 0 ,0 )
    Objective.SetParent             ( "Grant_Visitation" )
    Objective.RequireObjects        ( "PoolTable", 1 )
    
    Objective.CreateGrant           ( "Grant_Visitation_TV", 0 ,0 )
    Objective.SetParent             ( "Grant_Visitation" )
    Objective.RequireObjects        ( "Tv", 2 )
    
    Objective.CreateGrant           ( "Grant_Visitation_Phones", 0 ,0 )
    Objective.SetParent             ( "Grant_Visitation" )
    Objective.RequireObjects        ( "PhoneBooth", 5 )   
    
end

function CreateBasicSecurityGrant()
    Objective.CreateGrant           ( "Grant_BasicSecurity", 10000, 10000 )
    Objective.SetPreRequisite       ( "Completed", "Grant_bootstraps", 1 )
    
    Objective.CreateGrant           ( "Grant_BasicSecurity_Chief", 0, 0 )
    Objective.SetParent             ( "Grant_BasicSecurity" )
    Objective.RequireObjects        ( "Chief", 1 )
    
    Objective.CreateGrant           ( "Grant_BasicSecurity_Guards", 0, 0 )
    Objective.SetParent             ( "Grant_BasicSecurity" )
    Objective.RequireObjects        ( "Guard", 10 )
    
    Objective.CreateGrant           ( "Grant_BasicSecurity_Research", 0, 0 )
    Objective.SetParent             ( "Grant_BasicSecurity" )
    Objective.RequireResearched     ( "Patrols" )       
    
    Objective.CreateGrant           ( "Grant_BasicSecurity_Patrols", 0, 0 )
    Objective.SetParent             ( "Grant_BasicSecurity" )
    Objective.Requires              ( "PatrolGuards", "AtLeast", 3 )
end

function CreateEnhancedSecurityGrant()
    Objective.CreateGrant           ( "Grant_EnhancedSecurity", 15000, 15000 )
    Objective.SetPreRequisite       ( "Completed", "Grant_BasicSecurity", 1 )
    
    --Objective.CreateGrant           ( "Grant_EnhancedSecurity_Armoury", 0, 0 )
    --Objective.SetParent             ( "Grant_EnhancedSecurity" )
    --Objective.RequireRoom           ( "Armoury", true )
    
    --Objective.CreateGrant           ( "Grant_EnhancedSecurity_Guards", 0, 0 )
    --Objective.SetParent             ( "Grant_EnhancedSecurity" )
    --Objective.RequireObjects        ( "ArmedGuard", 2 )
    
    --Objective.CreateGrant           ( "Grant_EnhancedSecurity_Kennel", 0, 0 )
    --Objective.SetParent             ( "Grant_EnhancedSecurity" )
    --Objective.RequireRoom           ( "Kennel", true )
    
    --Objective.CreateGrant           ( "Grant_EnhancedSecurity_Dogs", 0, 0 )
    --Objective.SetParent             ( "Grant_EnhancedSecurity" )
    --Objective.RequireObjects        ( "DogHandler", 2 )
    
    Objective.CreateGrant           ( "Grant_EnhancedSecurity_PatrolDogs", 0, 0 )
    Objective.SetParent             ( "Grant_EnhancedSecurity" )
    Objective.Requires              ( "PatrolDogs", "AtLeast", 2 )
    
    Objective.CreateGrant           ( "Grant_EnhancedSecurity_PatrolArmed", 0, 0 )
    Objective.SetParent             ( "Grant_EnhancedSecurity" )
    Objective.Requires              ( "PatrolArmed", "AtLeast", 2 )
end

function CreateAdvancedSecurityGrant()
    Objective.CreateGrant           ( "Grant_AdvancedSecurity", 20000, 20000 )
    Objective.SetPreRequisite       ( "Completed", "Grant_EnhancedSecurity", 1 )
    
    Objective.CreateGrant           ( "Grant_AdvancedSecurity_Guards", 0, 0 )
    Objective.SetParent             ( "Grant_AdvancedSecurity" )
    Objective.RequireObjects        ( "Guard", 20 )
    
    --Objective.CreateGrant           ( "Grant_AdvancedSecurity_ResearchCCTV", 0, 0 )
    --Objective.SetParent             ( "Grant_AdvancedSecurity" )
    --Objective.RequireResearched     ( "Cctv" )   
    
    Objective.CreateGrant           ( "Grant_AdvancedSecurity_ResearchBodyArmour", 0, 0 )
    Objective.SetParent             ( "Grant_AdvancedSecurity" )
    Objective.RequireResearched     ( "BodyArmour" ) 
    
    Objective.CreateGrant           ( "Grant_AdvancedSecurity_ResearchTazers", 0, 0 )
    Objective.SetParent             ( "Grant_AdvancedSecurity" )
    Objective.RequireResearched     ( "Tazers" )  
    
    --Objective.CreateGrant           ( "Grant_AdvancedSecurity_Office", 0, 0 )
    --Objective.SetParent             ( "Grant_AdvancedSecurity" )
    --Objective.RequireRoom           ( "Security", true )
    
    Objective.CreateGrant           ( "Grant_AdvancedSecurity_CCTVMonitor", 0, 0 )
    Objective.SetParent             ( "Grant_AdvancedSecurity" )
    Objective.RequireObjects        ( "CctvMonitor", 1 )
    
    Objective.CreateGrant           ( "Grant_AdvancedSecurity_CCTVCameras", 0, 0 )
    Objective.SetParent             ( "Grant_AdvancedSecurity" )
    Objective.RequireObjects        ( "Cctv", 6 )    
end

function CreatePrisonerWorkforceGrant()
    Objective.CreateGrant           ( "Grant_PrisonerWorkforce", 10000, 10000 )
    Objective.SetPreRequisite       ( "Completed", "Grant_Maintenance", 1 )
    
    --Objective.CreateGrant           ( "Grant_PrisonerWorkforce_Research", 0, 0 )
    --Objective.SetParent             ( "Grant_PrisonerWorkforce" )
    --Objective.RequireResearched     ( "PrisonLabour" )
    
    --Objective.CreateGrant           ( "Grant_PrisonerWorkforce_Laundry", 0, 0 )
    --Objective.SetParent             ( "Grant_PrisonerWorkforce" )
    --Objective.RequireRoom           ( "Laundry", true )
    
    --Objective.CreateGrant           ( "Grant_PrisonerWorkforce_Cleaning", 0, 0 )
    --Objective.SetParent             ( "Grant_PrisonerWorkforce" )
    --Objective.RequireRoom           ( "CleaningCupboard", true )
    
    --Objective.CreateGrant           ( "Grant_PrisonerWorkforce_KitchenClass", 0, 0 )
    --Objective.SetParent             ( "Grant_PrisonerWorkforce" )
    --Objective.Requires              ( "ReformPassed", "KitchenInduction", 3 )
    
    Objective.CreateGrant           ( "Grant_PrisonerWorkforce_LaundryAssigned", 0, 0 )
    Objective.SetParent             ( "Grant_PrisonerWorkforce" )
    Objective.Requires              ( "PrisonerJobs", "Laundry", 3 )
    
    Objective.CreateGrant           ( "Grant_PrisonerWorkforce_KitchenAssigned", 0, 0 )
    Objective.SetParent             ( "Grant_PrisonerWorkforce" )
    Objective.Requires              ( "PrisonerJobs", "Kitchen", 3 )
    
    Objective.CreateGrant           ( "Grant_PrisonerWorkforce_CleaningAssigned", 0, 0 )
    Objective.SetParent             ( "Grant_PrisonerWorkforce" )
    Objective.Requires              ( "PrisonerJobs", "CleaningCupboard", 3 )
end

function CreateEducationReformGrant()
    Objective.CreateGrant           ( "Grant_EducationReformProgram", 15000, 40000 )
    Objective.SetPreRequisite       ( "Completed", "Grant_Administration", 1 )

    Objective.CreateGrant           ( "Grant_EducationReformProgram_Research", 0, 0 )
    Objective.SetParent             ( "Grant_EducationReformProgram" )
    Objective.RequireResearched     ( "Education" )
    
    Objective.CreateGrant           ( "Grant_EducationReformProgram_Classroom", 0, 0 )
    Objective.SetParent             ( "Grant_EducationReformProgram" )
    Objective.RequireRoom           ( "Classroom", true )
    
    Objective.CreateGrant           ( "Grant_EducationReformProgram_Desks", 0, 0 )
    Objective.SetParent             ( "Grant_EducationReformProgram" )
    Objective.RequireObjects        ( "SchoolDesk", 20 )  
    
    Objective.CreateGrant           ( "Grant_EducationReformProgram_FoundationEd", 0, 0 )
    Objective.SetParent             ( "Grant_EducationReformProgram" )
    Objective.Requires              ( "ReformPassed", "FoundationEducation", 10 )
    
    Objective.CreateGrant           ( "Grant_EducationReformProgram_GeneralEd", 0, 0 )
    Objective.SetParent             ( "Grant_EducationReformProgram" )
    Objective.Requires              ( "ReformPassed", "GeneralEducation", 1 )
end

function CreatePrisonLabourGrant()
    Objective.CreateGrant           ( "Grant_PrisonLabour", 20000, 10000 )
    Objective.SetPreRequisite       ( "Completed", "Grant_PrisonerWorkforce", 1 )
    
    --Objective.CreateGrant           ( "Grant_PrisonLabour_Workshop", 0, 0 )
    --Objective.SetParent             ( "Grant_PrisonLabour" )
    --Objective.RequireRoom           ( "Workshop", true )
    
    --Objective.CreateGrant           ( "Grant_PrisonLabour_Saw", 0, 0 )
    --Objective.SetParent             ( "Grant_PrisonLabour" )
    --Objective.RequireObjects        ( "WorkshopSaw", 2 )  
    
    --Objective.CreateGrant           ( "Grant_PrisonLabour_Press", 0, 0 )
    --Objective.SetParent             ( "Grant_PrisonLabour" )
    --Objective.RequireObjects        ( "WorkshopPress", 2 )  
    
    --Objective.CreateGrant           ( "Grant_PrisonLabour_Reform", 0, 0 )
    --Objective.SetParent             ( "Grant_PrisonLabour" )
    --Objective.Requires              ( "ReformPassed", "WorkshopInduction", 5 )
    
    Objective.CreateGrant           ( "Grant_PrisonLabour_Plates", 0, 0 )
    Objective.SetParent             ( "Grant_PrisonLabour" )
    Objective.RequireManufactured   ( "LicensePlate", 30 )      
end

function CreateFurnitureManufacturingGrant()
    Objective.CreateGrant           ( "Grant_FurnitureManufacturing", 10000, 10000 )
    Objective.SetPreRequisite       ( "Completed", "Grant_PrisonLabour", 1 )
    
    --Objective.CreateGrant           ( "Grant_FurnitureManufacturing_Forestry", 0, 0 )
    --Objective.SetParent             ( "Grant_FurnitureManufacturing" )
    --Objective.RequireRoom           ( "Forestry", true )
    
    --Objective.CreateGrant           ( "Grant_FurnitureManufacturing_Table", 0, 0 )
    --Objective.SetParent             ( "Grant_FurnitureManufacturing" )
    --Objective.RequireObjects        ( "CarpenterTable", 2 )  
    
    --Objective.CreateGrant           ( "Grant_FurnitureManufacturing_Reform", 0, 0 )
    --Objective.SetParent             ( "Grant_FurnitureManufacturing" )
    --Objective.Requires              ( "ReformPassed", "Carpentry", 2 )
    
    Objective.CreateGrant           ( "Grant_FurnitureManufacturing_Bed", 0, 0 )
    Objective.SetParent             ( "Grant_FurnitureManufacturing" )
    Objective.RequireManufactured   ( "SuperiorBed", 10 )       
end

function CreateReduceStaffStressGrant()
    Objective.CreateGrant           ( "Grant_ReduceStaffStress", 0, 10000 )
    
    Objective.CreateGrant           ( "Grant_ReduceStaffStress_Staffroom", 0, 0 )
    Objective.SetParent             ( "Grant_ReduceStaffStress" )
    Objective.RequireRoom           ( "Staffroom", true )
    
    Objective.CreateGrant           ( "Grant_ReduceStaffStress_FreeGuards", 0, 0 )
    Objective.SetParent             ( "Grant_ReduceStaffStress" )
    Objective.Requires              ( "AvailableGuards", "AtLeast", 5 )
    
    Objective.CreateGrant           ( "Grant_ReduceStaffStress_RestedStaff", 0, 0 )
    Objective.SetParent             ( "Grant_ReduceStaffStress" )
    Objective.Requires              ( "ExhaustedStaffPercent", "AtMost", 5 )
end

function  CreateShortTermInvestment()
    Objective.CreateGrant           ( "Grant_ShortTermInvestment", -5000, 16000 )
    Objective.SetPreRequisite       ( "Unlocked", "Finance", 0 )
    Objective.HiddenWhileLocked     ()
    
    Objective.CreateGrant           ( "Grant_ShortTermInvestment_Wait", 0, 0 )
    Objective.SetParent             ( "Grant_ShortTermInvestment" )
    Objective.RequireTimePassed     ( 4320 )
end

function CreateLongTermInvestment()
    Objective.CreateGrant           ( "Grant_LongTermInvestment", -5000, 16000 )
    Objective.SetPreRequisite       ( "Unlocked", "Finance", 0 )
    Objective.HiddenWhileLocked     ()
    
    Objective.CreateGrant           ( "Grant_LongTermInvestment_Wait", 0, 0 )
    Objective.SetParent             ( "Grant_LongTermInvestment" )
    Objective.RequireTimePassed     ( 10080 )
end

function CreateNutritionResearchGrant()
    Objective.CreateGrant           ( "Grant_NutritionResearch", 0, 15000 )
    Objective.SetPreRequisite       ( "Unlocked", "Health", 0 )
    Objective.SetPreRequisite       ( "Unlocked", "MentalHealth", 0 )
    Objective.SetPreRequisite       ( "Prisoners", "AtLeast", 20 )
    
    Objective.CreateGrant           ( "Grant_NutritionResearch_Poor", 0, 0 )
    Objective.SetParent             ( "Grant_NutritionResearch" )
    Objective.RequireSetMeals       (1)
    
    Objective.CreateGrant           ( "Grant_NutritionResearch_Good", 0, 0 )
    Objective.SetParent             ( "Grant_NutritionResearch" )
    Objective.RequireSetMeals       (3)
end

function CreateDrugSearchGrant()
    Objective.CreateGrant           ( "Grant_DrugSearch", 0, 15000 )
    Objective.SetPreRequisite       ( "Prisoners", "AtLeast", 30 )
    
    Objective.CreateGrant           ( "Grant_DrugSearch_Find", 0, 0 )
    Objective.SetParent             ( "Grant_DrugSearch" )
    Objective.Requires              ( "ContrabandFound", "Narcotics", 10 )
end

function CreateContrabandSupplyGrant()
    Objective.CreateGrant           ( "Grant_ContrabandSupply", 0, 20000 )
    Objective.SetPreRequisite       ( "Prisoners", "AtLeast", 40 )
    
    Objective.CreateGrant           ( "Grant_ContrabandSupply_Tools", 0, 0 )
    Objective.SetParent             ( "Grant_ContrabandSupply" )
    Objective.Requires              ( "ContrabandSupply", "Tools", 0 )
    
    Objective.CreateGrant           ( "Grant_ContrabandSupply_Weapons", 0, 0 )
    Objective.SetParent             ( "Grant_ContrabandSupply" )
    Objective.Requires              ( "ContrabandSupply", "Weapons", 0 )
end