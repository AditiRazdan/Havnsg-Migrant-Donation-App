//
//  constant.swift
//  Donation
//
//  Created by Kanhu Dash on 29/01/22.
//

import Foundation
import UIKit

struct ApiEndpoints
{
    static let loginUserByPassword = "user/login/password"
    static let loginUserByOTP = "user/login/otp"
    static let validateLoginOTP = "user/validateOtp"
    static let resendOTP = "user/resendOtp"
    static let register = "user/signup"
    static let changePassword = "user/changePassword"
    static let forgetPassword = "user/forgetPassword"
    static let getCategories = "category/getAllCategory"
    static let getSubCategories = "category/getAllSubCategory"
    static let addCategory = "category/addCategory"
    static let addSubCategory = "category/addSubcategory"
    static let updateCategory = "category/updateCategory/"
    static let updateSubcategory = "category/updateSubcategory/"
    static let getProfile = "user/getProfile/"
    static let updateProfile = "user/editProfile/"
    static let donateRequest = "request/"
    static let receiverRequest = "request/receive"
    static let allDonationHistory = "request/donationList/"
    static let allDonationHistoryByStatus = "request/donationList/"
    static let allReceiveHistory = "request/receiveList/"
    static let allReceiveHistoryByStatus = "request/receiveList/"
    static let deleteDonationRequest = "request/removeDonate/"
    static let deleteReceiveRequest = "request/removeReceive/"
    static let getRecieveRequestDetail = "request/receiveDetails/"
    static let editReceiveRequest = "request/editReceiveDetails/"
    static let editDonateRequest = "request/editDonationDetails/"
    static let getDonationRequestDetail = "request/donationDetails/"
    static let changeReceiveRequestStatus = "request/changeReceiveStatus/"
    static let changeDonationRequestStatus = "request/changeDonationStatus/"
    static let allReceiveHistoryByRegion = "request/receiveListByRegion/"
    static let allDonationHistoryByRegion = "request/donationListByRegion/"
    static let allPendingRequests = "request/getRequests"
    static let allPendingDonationRequests = "request/getDonates"
    static let initialData = "staticData/:platform"
    static let matchedRequest = "request/matchedRequest"
    static let matchedRequestDetailsByRequestId = "request/matchedRequestDetailsByRequestId"
}

let BASE_URL = "https://havnsg.org/"

//let BASE_URL = "https://havnsg.org"
let IMAGE_URL = "https://havnsg.org/"

let obj_UserDefault = UserDefaults()


enum Titles: String {
    case loginTitle = "Please login to your account"
    case registerTitle = "Please enter your information below."
    case forgotPasswod = "Forgot Password?"
    case orderDetails = "Order Details"
}

// side bars
let donerData = ["Account","Items Requested","New Donation Offer","About Us","Logout"]
let receiverData = ["Account","Items Offered","New Donation Request","About Us","Logout"]
let volunteerData = ["Receive Requests","Donation Offer","Matched","About Us","Logout"]
let adminData = ["Add Category","Add Sub-category","All Donations","Receive Requests","About Us","Logout"]

enum ErrorMSG: String {
    
    case NO_Internet = "Please Check Your Internet Connection And Try Again"
    case Server_Error = "There is a problem with the server, please try again later."
    case pleaseProvideValidation = "Please Provide"
    case pleaseEnterYourValidation = "Please Enter Your"
    case passwordDoesnotMatch = "Password doesn't match"
    case ƒ = "is not valid"
    case passwordValidation = "Password must contain 1 small & 1 capital letter, 1 digit & 1 special character and must contain atleast 8 character."
    case NO_ITEM_FOUND = "No items added"
}

enum IntroductionTitle: String {
    case first_Page = "A Little Help Goes a Long Way"
    case scond_Page = "The People Behind Our City"
    case third_Page = "Give What Matters"
}

enum IntroductionDescription: String {
    case first_Page = "Many of us want to help, but don’t always know how. HAVN makes it simple to support migrant workers — anytime, anywhere."
    case scond_Page = " Migrant workers help build, clean, and care for the places we call home. They deserve to feel valued and supported."
    case third_Page = "Donate new and pre-loved items that are actually needed — shared directly by migrant workers themselves."
}

enum DonorSideBar: String {
    case account = "Account"
    case receivedRequest = "Received Request"
    case createNewRequest = "Create New Request"
}

enum ReciverSideBar: String {
    case account = "Account"
    case receivedRequest = "Received Request"
    case createNewRequest = "Create New Request"
}

//enum SidebarTitle: String {
//
//}
enum AcceptRequestButtonTitle: String {
    case forReceiver = "Accept Donation Offer"
    case forDoner = "Accept Donation Request"
}

enum TabBarTitleForDoner: String {
    case home = "Home"
    case createRequest = "Create Request"
    case account = "Account"
    case receivedRequest = "Items Requested"
}

enum TabBarTitleForVolunteer: String {
    case home = "Home"
    case request = "Request"
    case matched = "Matched"
}


enum TabBarTitleForReceiver: String {
    case home = "Home"
    case createRequest = "Create Request"
    case account = "Account"
    case donationOffer = "Items Offered"
}

enum ButtonTite : String {
    case button1Receiver = "Make a New Donation Request"
    case button1Donor = "Make a New Donation Offer"
    case button1Volunteer = "All Items Requested"
    case button1Admin = "Categories"
    case button2Receiver = "Match an Existing Item Offered"
    case button2Donor = "Match an Existing Item Requested"
    case button2Volunteer = "Matched Request"
    case button2Admin = "Requests"
    case optionaLabel = "Push notification has been sent to both donor and receiver. Contact details mentioned below."
}

enum WelcomeLabelText : String {
    case receiver = "Welcome to HAVN, where we Help All Voices be Noticed."
//    case donor = "Welcome to HAVN, where we Help All Voices be Noticed."
//    case volunteer = "Welcome to HAVN, where we Help All Voices be Noticed."
//    case admin = "Welcome to HAVN, where we Help All Voices be Noticed."
    case welcomeContent = """
    This app connects our community through simple acts of giving, fostering dignity and support for
    Singapore's migrant workers.
    Start browsing or list an item to make a difference today.
    """
}

enum MessageInHomeScreen : String {
    case messageForDonor = "Please select the category in which you want to donate"
    case messageForReceiver = "Please select the category in which you want to receive"
}

enum AboutUs : String {
    case aboutTitle = "Welcome to the HAVN Community."
    case aboutUs = """
    “Helping All Voices be Noticed was born out of a moment of compassion, when migrant workers stepped in to help a family in need. Their kindness sparked a mission to bridge the gap between generosity and need.
    This app is how we bring that mission to life. It’s a community space for direct connection, where everyday necessities can be shared with dignity.
    Every exchange here is a step toward a more inclusive Singapore. Thank you for being part of this mission.
    The HAVN Initiative
    Learn more about our wider community projects at havnsg.com.
    """
}
enum Event : String {
    case event =   """
A cultural celebration bringing migrant workers and the community together.
"""
}
enum PageTite: String {
    case aboutUs = "About Us"
    case eventPage = "Event"
    case profile = "Profile"
    case subCategory = "Sub Category"
    case matchedDetail = "Matched Detail"
    case matched = "Matched"
    case receivedRequestForDoner = "Items Requested"
    case receivedRequestForReceiver = "New Request"
    case createDonationRequestForDoner = "New Donation"
    case historyForDoner = "My Account History"
    case historyForReceiver = "Account History"
    case addSubCategory = "Add Sub-Category"
    case addCategory = "Add Category"
    case category = "Category"
}

//enum DonorPageTitle: String {
//    case createDonationRequest =
//    case history = "Account"
//    case receivedRequest =
//}
//
//enum ReceiverPageTitle: String {
//    case createDonationRequest = "Donation"
//    case history = "Account"
//    case receivedRequest = "Request"
//}


