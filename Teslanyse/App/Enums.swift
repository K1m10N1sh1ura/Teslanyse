//
//  Enums.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 03.03.24.
//

import Foundation

protocol WithDescription {
    var description: String { get }
}

protocol WithDefinition {
    var definition: String { get }
}

enum QuarterDataEnum: String, CaseIterable, WithDescription {
    case revenue = "Revenue"
    case profit = "Profit"
    case margin = "Gross GAAP margin"
    case operatingMargin = "Operating margin"
    case cash = "Cash"
    case freeCashFlow = "Free cash flow"
    case operatingExpenses = "Operating expenses"
    case researchAndDevelopementExpenses = "Research and developement"
    case sellingGeneralAndAdministrativeExpenses = "Selling, general and administrative"
    case automotiveRevenue = "Automotive revenue"
    case automotiveCostOfRevenue = "Automotive cost of revenue"
    case automotiveProfit = "Automotive profit"
    case automotiveMargin = "Automotive margin"
    case automotiveCostOfGoodsSold = "Automotive cost of goods sold"
    case automotiveLeasingRevenue = "Leasing revenue"
    case automotiveLeasingProfit = "Leasing profit"
    case automotiveLeasingMargin = "Leasing margin"
    case deliveredCars = "Delivered cars"
    case producedCars = "Produced cars"
    case deliveredModel3Y = "Delivered Model 3 and Y"
    case deliveredOtherModels = "Delivered other models"
    case producedModel3Y = "Produced Model 3 and Y"
    case producedOtherModels = "Produced other models"
    case deliveredCarsAccumulated = "Delivered cars accumulated"
    case producedCarsAccumulated = "Produced cars accumulated"
    case deliveredModel3YAccumulated = "Delivered Model 3 and Y accumulated"
    case deliveredOtherModelsAccumulated = "Delivered other models accumulated"
    case producedModel3YAccumulated = "Produced Model 3 and Y accumulated"
    case producedOtherModelsAccumulated = "Produced other models accumulated"
    case energyRevenue = "Energy revenue"
    case energyCostOfRevenue = "Energy cost of revenue"
    case energyStorage = "Energy storage"
    case energySotrageAccumulated = "Energy storage accumulated"
    case energyProfit = "Energy profit"
    case energyMargin = "Energy margin"
    case energyCostOfGoodsSold = "Energy cost of goods sold"
    case serviceRevenue = "Service revenue"
    case serviceProfit = "Service profit"
    case serviceMargin = "Service margin"
    case solarDeployed = "Solar deployed"
    case solarDeployedAccumulated = "Solar deployed accumulated"
    case superchargerStations = "Supercharger stations"
    case superchargerConnectors = "Supercharger connectors"
    case superchargerStationsAccumulated = "Supercharger stations accumulated"
    case superchargerConnectorsAccumulated = "Supercharger connectors accumulated"
    
    var description: String {
        return self.rawValue
    }
}

enum ChinaWeeklySalesDataEnum: String, CaseIterable, WithDescription {
    case units = "Units"

    var description: String {
        return self.rawValue
    }
}

enum TeslaVehicleModel: String, CaseIterable, WithDescription, WithDefinition {
    case model3Y = "Model 3/Y"
    case other = "Other models"
    case all = "Total"
    
    var description: String {
        return self.rawValue
    }
    
    var definition: String {
        switch self {
        case .model3Y:
            return "This category includes Tesla Model 3 and Model Y vehicles. The Model 3 is a more affordable, high-volume compact sedan, while the Model Y is a compact SUV that shares many components with the Model 3, designed to balance efficiency and usability."
        case .other:
            return "Encompasses Tesla's other vehicle offerings, including the Model S and Model X, which are Tesla's premium sedan and SUV, respectively. It also includes the Cybertruck, Tesla's upcoming electric pickup truck, and the Tesla Semi, an electric freight truck. These models represent Tesla's expansion into various segments of the automotive market."
        case .all:
            return "Represents the entirety of Tesla's vehicle lineup, including the Model S, Model 3, Model X, Model Y, Cybertruck, and Semi. This comprehensive category reflects Tesla's diverse range of electric vehicles designed to suit a variety of customer needs and preferences across different market segments."
        }
    }
}

enum VehicleSaleState: String, CaseIterable, WithDescription, WithDefinition {
    case produced = "Produced"
    case delivered = "Delivered"
    
    var description: String {
        return self.rawValue
    }
    
    var definition: String {
        switch self {
        case .produced:
            return "Refers to the total number of units manufactured within a specific time frame. This metric tracks the production capacity and efficiency, highlighting the company's ability to produce goods to meet demand."
        case .delivered:
            return "Denotes the total number of units that have been shipped to and received by buyers. It's an indicator of sales success and the company's efficiency in distributing its products to the market or end consumers."
        }
    }
}

enum FinancialDataOption: String, CaseIterable, WithDescription, WithDefinition {
    case revenue = "Revenue"
    case profit = "Profit"
    case grossGAAPMargin = "Grosw GAAP margin"
    case cash = "Cash"
    case freeCashFlow = "Free cash flow"
    case operatingMargin = "Operating margin"
    case researchAndDevelopementExpenses = "Research and Developement expenses"
    case sellingGeneralAndAdministrativeExpenses = "Selling, general and administrative expenses"
    
    var description: String {
        return self.rawValue
    }
    
    var definition: String {
        switch self {
        case .revenue:
            return "Revenue refers to the total income generated by a business through its normal business operations. It's the money earned from selling goods or services."
        case .profit:
            return "Profit is the financial gain realized when the revenue earned from business activities exceeds the expenses, costs, and taxes incurred in generating that revenue."
        case .grossGAAPMargin:
            return "Gross GAAP Margin is a financial metric that represents the percentage of revenue remaining after deducting the cost of goods sold (COGS) from total revenue. It indicates the profitability of a company's core business activities, excluding other operating expenses such as selling, general, and administrative expenses."
        case .cash:
            return "Cash refers to the amount of currency that a company has on hand at any given time. This includes all liquid assets that are readily available for use in immediate transactions, operations, or investments."
        case .freeCashFlow:
            return "Free Cash Flow (FCF) is a measure of a company's financial performance that shows how much cash is generated by the business after deducting capital expenditures from its operating cash flow. It represents the excess cash that a company can use to pay dividends, repay debt, or invest in growth opportunities."
        case .operatingMargin:
            return "Operating Margin is a profitability ratio that shows what percentage of a company's revenue is left over after paying for variable costs of production such as wages and raw materials, but before paying interest or tax. It indicates how efficiently a company can manage its operating expenses."
        case .researchAndDevelopementExpenses:
            return "Research and Development (R&D) Expenses are costs associated with the research and development of a company’s goods or services. These expenses are aimed at discovering new knowledge, developing new products, or improving existing products or processes."
        case .sellingGeneralAndAdministrativeExpenses:
            return "Selling, General and Administrative (SG&A) Expenses are the combined total of all operating expenses directly tied to the selling of products and services, as well as the overall administrative expenses of running the company. This includes salaries of non-production employees, marketing expenses, rent, utilities, and office supplies."
        }
    }
}

enum AutomotiveFinancialDataOption: String, CaseIterable, WithDescription, WithDefinition {
    case revenue = "Revenue"
    case profit = "Profit"
    case margin = "Margin"
    case cogs = "Cost of goods sold"
    case regulatoryCredits = "Regulatory credits"
    case leasingRevenue = "Leasing revenue"
    case leasingProfit = "Leasing profit"
    case leasingMargin = "Leasing margin"

    var description: String {
        return self.rawValue
    }
    
    var definition: String {
        switch self {
        case .revenue:
            return "Revenue refers to the total income generated by a business through its normal business operations. It's the money earned from selling goods or services."
        case .profit:
            return "Profit is the financial gain realized when the revenue earned from business activities exceeds the expenses, costs, and taxes incurred in generating that revenue."
        case .margin:
            return "Margin typically refers to the difference between the selling price of a product or service and the cost incurred to produce or provide it. Gross margin specifically refers to the difference between revenue and the cost of goods sold (COGS), expressed as a percentage."
        case .cogs:
            return "Cost of Goods Sold (COGS) represents the direct costs associated with producing or purchasing the goods that a company sells during a specific period. These costs typically include materials, labor, and overhead expenses directly tied to production."
        case .regulatoryCredits:
            return "Regulatory Credits represent income from selling surplus government credits awarded for the production and sale of environmentally friendly products, such as electric vehicles. These credits can be sold to other companies that need to offset their emissions or comply with environmental regulations."
        case .leasingRevenue:
            return "Leasing Revenue is the income a company earns from leasing its products or assets to customers. For businesses involved in selling vehicles or equipment, this can be a significant source of income, representing payments received over the lease term for the use of these assets."
        case .leasingMargin:
            return "Leasing Margin refers to the profit made from leasing activities, calculated as the difference between leasing revenue and the costs associated with leasing out assets, expressed as a percentage of leasing revenue. This margin reflects the profitability of the leasing operations."
        case .leasingProfit:
            return "Leasing Profit refers to the net income earned from leasing operations, after subtracting all associated expenses from leasing revenue. This includes costs such as maintenance, repair, depreciation of leased assets, and administrative expenses related to the leasing process. It highlights the efficiency and profitability of a company's leasing activities."
        }

    }
}

enum ServiceFinancialsOption: String, CaseIterable, WithDefinition, WithDescription {
    case revenue = "Revenue"
    case profit = "Profit"
    case margin = "Margin"
    
    var description: String {
        return self.rawValue
    }
    
    var definition: String {
        switch self {
        case .revenue:
            return "Service and Other Revenue refers to income generated from various non-core business activities, including service fees, maintenance contracts, software subscriptions, and any other miscellaneous sources of income. This category is distinct from the primary product sales or leasing revenue."
        case .profit:
            return "Service and Other Profit represents the net earnings from service-related and miscellaneous activities after subtracting the direct and indirect costs associated with providing these services and other activities. It is a key indicator of the profitability of a company's ancillary operations."
        case .margin:
            return "Service and Other Margin calculates the profitability of a company's service and other non-core activities by comparing the profit from these activities to the revenue they generate. It is expressed as a percentage, illustrating the efficiency and financial health of these supplemental business areas."
            
        }
    }
}

enum EnergyOptions: String, CaseIterable, WithDescription, WithDefinition {
    case storageDeployed = "Storage"
    case solarDeployed = "Solar"
    
    var description: String {
        return self.rawValue
    }
    
    var definition: String {
        switch self {
        case .storageDeployed:
            return "Represents the total capacity of energy storage solutions deployed, measured in megawatt-hours (MWh). This includes products like Powerwall, Powerpack, and Megapack, which store electricity for residential, commercial, and utility-scale projects, respectively."
        case .solarDeployed:
            return "Denotes the total area of solar energy products installed, measured in square feet or megawatts. This encompasses Solar Roof and traditional solar panel installations that convert sunlight into electricity, for both residential and commercial applications."
        }
    }
}

enum EnergyFinancialDataOption: String, CaseIterable, WithDescription, WithDefinition {
    case revenue = "Revenue"
    case costOfRevenue = "Cost of revenue"
    case profit = "Profit"
    case margin = "Margin"
    case cogs = "Cost of goods sold"
    
    var description: String {
        return self.rawValue
    }
    
    var definition: String {
        switch self {
        case .revenue:
            return "Revenue refers to the total income generated by a business through its normal business operations. It's the money earned from selling goods or services."
        case .costOfRevenue:
            return "Cost of Revenue is similar to COGS but may encompass additional expenses beyond the direct costs associated with producing goods, such as sales commissions, shipping costs, and other expenses directly related to generating revenue. It represents the total cost incurred to generate the revenue from a business's primary operations."
        case .profit:
            return "Profit is the financial gain realized when the revenue earned from business activities exceeds the expenses, costs, and taxes incurred in generating that revenue."
        case .margin:
            return "Margin typically refers to the difference between the selling price of a product or service and the cost incurred to produce or provide it. Gross margin specifically refers to the difference between revenue and the cost of goods sold (COGS), expressed as a percentage."
        case .cogs:
            return "Cost of Goods Sold (COGS) represents the direct costs associated with producing or purchasing the goods that a company sells during a specific period. These costs typically include materials, labor, and overhead expenses directly tied to production."
        }
    }
}

enum SuperchargerInfrastructure: String, CaseIterable, WithDescription, WithDefinition {
    case stations = "Stations"
    case connectors = "Connectors"
    
    var description: String {
        return self.rawValue
    }
    
    var definition: String {
        switch self {
            case .stations:
                return "Refers to the total number of Supercharger stations available within the network. A station includes one or more chargers designed to offer rapid charging for electric vehicles."
            case .connectors:
                return "Denotes the individual charging points available at Supercharger stations. Each station can have multiple connectors, allowing several vehicles to charge simultaneously."
        }
    }
}

enum SelectionYesNo: String, CaseIterable, WithDescription {
    case yes = "Yes"
    case no = "No"
    var description: String {
        return self.rawValue
    }
}

enum NumberFormatType: String {
    case dollar = "USD"
    case percent = "%"
    case number = "Num"
    case power = "Wh"
    case energy = "Watts"
}

enum ChartStyle: String, CaseIterable {
    case barChart = "Bar chart"
    case lineChart = "Line chart"
    case pointChart = "Point chart"
    
    var description: String {
        return self.rawValue
    }
}

enum ChartColor: String, CaseIterable {
    case gray = "Gray"
    case blue = "Blue"
    case green = "Green"
    case red = "Red"
    case yellow = "Yellow"
 
    var description: String {
        return self.rawValue
    }
}

