import 'package:config/config.dart';
import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class TermsAndConditionsView extends StatelessWidget {
  static String path = 'terms-and-conditions-view';
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(title: 'Terms and Conditions'),
      body: const ScaffoldBody(
          body: SingleChildScrollView(
        child: Column(
          children: [
            Text("""
Welcome to our Terms and Conditions of Use. These terms affect your legal rights, endeavour to read them and treat with utmost importance.

TERMS AND CONDITION
By using our website [$APP_PARTNER_DOMAIN_NAME] and all related sites and/or services, you agree to these Terms of Use. The website Privacy Policy (where applicable) are incorporated by reference into these Terms of Use.
This Terms of Use is an agreement between you and COMPANY (‘The Company’). It details our obligations to you. It also highlights certain risks in using the services and you must consider such risks carefully as you will be bound by the provisions of this Agreement through your use of this website or any of our services.
Acceptance of Terms of Use

By accessing, visiting, or using the website, you accept and agree to be bound by the Terms. Please read carefully. Further, you shall be subject to any additional terms of use that apply when you use certain products or posted guidelines or rules applicable to our Services, which may be posted and modified from time to time. All such guidelines are hereby incorporated by reference into the Terms.

ANY ACCESS, USE or PARTICIPATION IN THE SERVICES WILL CONSTITUTE ACCEPTANCE OF THE TERMS. IF YOU DO NOT AGREE TO THESE TERMS OF USE, PLEASE DO NOT USE THE SERVICES OR OUR SITE OR MOBILE APPLICATION OR ACCESS OUR SERVICES.

About Us
We are a ,,,,,,,,,,,,,,,,,, describe the business 
Our Service
We provide ……………….. insert service description (“Services”)..  We are not a bank and do not offer banking services as defined by the Banks and Other Financial Institutions Act, 2020.
Our platform seamlessly integrates with both global and local licensed payment partners. It features a robust multi-currency system, ensuring swift global deployment across African nations in under a month.

Who May Use Our Services?
You may use the Services only if you agree to form a binding contract with the COMPANY and are not a person barred from receiving services under the laws of the applicable jurisdiction. If you are accepting these Terms and using the Services on behalf of a company, business, or organization, you represent and warrant that you are authorized to do so.
Eligibility
By using the Services, you represent that: 
	•	You have attained the age of 18 years;
	•	You are of sound mind and have the capacity to enter into a legally binding contract;
	•	All personal information that you provide about yourself is accurate and true to the best of your knowledge; and you have the responsibility to maintain the accuracy of the information at all times.
	•	You have carefully considered the risks involved with using the Services; and
	•	Your use of the Services does not violate any applicable law or regulation.

User registration and account protection
Account creation
While you can browse the site and utilise the Checkout without creating a user account (“Account”), accessing and utilising our Services requires you to have an Account. In creating an Account, you must provide us with accurate and complete registration information as prompted during the registration process, including your name, a valid email address which functions as your username and a password of your choice, subject to certain requirements. Each Account registration is for a single user only. You shall not misrepresent your identity or your affiliation with any person or organisation and you are not allowed to use another user’s Account for any purpose whatsoever.
You may access the profile associated with your Account (“Profile”) on the App when you are logged in. When you access your Profile, you can edit certain information, including your email address and password, or any additional information relating to your Profile. You can also contact us directly at insert email  to edit your information. It is your responsibility to ensure your contact information is accurate and up to date.
Identity verification - KYC/KYB
You are required to provide valid identification documents to be verified before you are fully onboarded to the Services. Your account will be restricted to certain limits if your know your customer (“KYC”) or know Your Business “KYB” is not completed and/or your identity is not verified.
Account protection
You are responsible for maintaining the security and confidentiality of your username and password and may not share your Account information with third parties or allow third parties to use your Account. If you believe an unauthorised person has obtained your password or accessed your Account, you must notify us immediately via email at insert email. We will not be liable for any loss that you may incur as a result of someone else using your password or Account, either with or without your knowledge or permission. However, you may be held liable for any losses we or another related party incur due to someone else using your Account.

Intellectual Property Protection
Subject to your compliance with these Terms, COMPANY grants you a limited, non-exclusive, non-sub licensable, revocable, non-transferable license to access and view any content made available on or through the Services and accessible to you, solely for the uses authorised by these Terms and any other agreement incorporated into these Terms.
The Services, entire contents, features and functionality (including but not limited to all information, software, text, displays, images, video and audio, and the design, selection and arrangement thereof) on all our platforms and channels, are owned by COMPANY, its licensors or other providers of such material and are protected by the laws of the Federal Republic of Nigeria and international copyright, trademark, patent, trade secret and other intellectual property or proprietary rights laws. The content/material may not be copied, modified, reproduced, downloaded or distributed in any way, in whole or in part, without the express prior written permission of the Company, unless and except as is expressly provided in these Terms & Conditions. Any unauthorized use of the material is prohibited. 
You may use the website solely for the purposes authorised  and/or to learn about our products and services, and solely in compliance with these Terms; provided that you do not remove any proprietary notice language in our content or part thereof, do not copy or post such content or part of content to any networked computer or broadcast it in any media, make no modifications to any such content or part of content and not make any additional representations or warranties relating to the Services or/and The Company’s products or/and services.
Prohibited use of the website
By using the website, you agree that you will not with the Company’s consent and approval:
	•	use any of the Services in violation of these Terms;
	•	copy, modify, create a derivative work from, reverse engineer or reverse assemble the website, the App function, or otherwise attempt to discover any source code, or allow any third party to do so;
	•	use, display, mirror or frame the Content, or any individual element within the COMPANY’s website, the COMPANY’s name, any trademark, logo or other proprietary information belonging to the COMPANY, or the layout and design of any page or form contained on a page in the website, without the COMPANY’s express written consent;
	•	dilute, tarnish or otherwise harm the Company’s brand in any way, including through unauthorized use of our Content, registering and/or using the “COMPANY” name or derivative terms in domain names, trade names, trademarks or other source identifiers, or registering and/or using domains names, trade names, trademarks or other source identifiers that closely imitate or are confusingly similar to the Company’s domains, trademarks, taglines, promotional campaigns or Content;
	•	Sell, assign, sublicense, distribute, commercially exploit, grant a security interest in or otherwise transfer any right in, or make available to a third party, the Services or any part thereof;
	•	Use any page-scrapes, "robots," "spiders," or other automatic device, program, algorithm or methodology, or any similar or equivalent manual process, to access, copy or monitor any portion of the Site or the Application.
	•	Use the Services in any manner that damages, disables, overburdens, or impairs the Services or interferes with any other party's use and enjoyment of any of the Services;
	•	Utilize the Services for any illegal purpose;
	•	Attempt to gain unauthorized access to any of the Services;
	•	Probe, scan or test the vulnerability of the website or any network connected to the website, or breach the security or authentication measures on the website or any network connected to the website;
	•	Take any action that imposes an unreasonable or disproportionately large load on the infrastructure of the website or any systems or networks connected to the website;
	•	Use any device, software or routine to interfere or attempt to interfere with the proper working of any of the Services.

Third-party services
We may display, include or make available third-party content (including data, information, applications and other products services) or provide links to third-party websites or services ("Third- Party Services"). Third-Party Services and links thereto are provided solely as a convenience to you and you access and use them entirely at your own risk and subject to such third parties' terms and conditions.
You acknowledge and agree that COMPANY shall not be responsible for any Third-Party Services, including their accuracy, completeness, timeliness, validity, copyright compliance, legality, decency, quality or any other aspect thereof. The Company does not assume and shall not have any liability or responsibility to you or any other person or entity for any Third-Party Services.

Disclaimer & Limitations of liability
To the maximum extent permitted by applicable law, the Company disclaims any and all representations, warranties and conditions relating to the Services and the use of the Services (including, without limitation, any warranties implied by law in respect of satisfactory quality, fitness for purpose and/or the use of reasonable care and skill).
COMPANY MAKES NO REPRESENTATIONS ABOUT THE SUITABILITY, RELIABILITY, AVAILABILITY, TIMELINESS, SECURITY OR ACCURACY OF THE PLATFORM AND THEIR CONTENT FOR ANY PURPOSE. THE SITE, APP AND THEIR CONTENT ARE DELIVERED ON AN "AS-IS" AND "AS-AVAILABLE" BASIS. THE CONTENT MAY INCLUDE INACCURACIES OR TYPOGRAPHICAL ERRORS OR OTHER ERRORS OR INACCURACIES AND MAY NOT BE COMPLETE OR CURRENT.
IN NO EVENT SHALL THE COMPANY BE LIABLE OR RESPONSIBLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, CONSEQUENTIAL, SPECIAL OR EXEMPLARY DAMAGES OF ANY KIND, INCLUDING WITHOUT LIMITATION, LOST PROFITS OR LOST OPPORTUNITIES, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGES IN ADVANCE AND REGARDLESS OF THE CAUSE OF ACTION UPON WHICH ANY SUCH CLAIM IS BASED.
YOUR SOLE REMEDY AGAINST THE COMPANY FOR DISSATISFACTION WITH THE SERVICES IS TO STOP USING ANY OR ALL OF THE AFFECTED SERVICES.
Without prejudice to the foregoing provisions, your use of our site and services is at your own risk. You agree that the Company will no way be liable for (a) any direct, indirect, special, incidental punitive, consequential, punitive, special or exemplary damages or (b) any damages whatsoever in excess of the amount of the transaction or (including, without limitation, those  damages resulting from revenue loss of revenues, lost profits, profit loss of, use, data, goodwill, loss of use , business interruption, or any other intangible losses), (whether the Company has been advised of the possibility of such damages or not) arising out of or in connection with the Company’s website or services (including, without limitation, use, to inability to use, or arising from the results  of use of the Company’s website or services) whether such damages are based on warranty, tort, contract, tort, statute, or any other legal theory.
The above disclaimer applies to any damages, liability or injuries caused by any failure of performance, error, omission, interruption, deletion, defect, delay in operation or transmission, computer virus, communication line failure, theft or destruction of or unauthorized access to, alteration of, or use, whether for breach of contract, tort, negligence or any other cause of action.
Some jurisdictions do not allow the exclusion of or limitations on implied warranties or the limitations on the applicable statutory rights of a consumer, so some or all of the above exclusions and limitations may not apply to you.

Disclaimer on cryptocurrency activities
In line with the relevant Central Bank of Nigeria directives on cryptocurrency use in Nigeria, Our Company declares that it is in no way a dealer in cryptocurrency exchange. We do not accept, buy or make payouts to our customers in any cryptocurrency on our website and nothing should be taken as an offer to sell, buy, hold or make a payment in cryptocurrency or any financial instrument not approved by the Central Bank of Nigeria.


Updates, Modifications & Amendments
We may need to update, modify or amend our Terms of Use as our technology evolves. We reserve the right to make changes to this Terms of Use at any time by giving notice to users on this page.
We advise that you check this page often, referring to the date of the last modification on the page If a user objects to any of the changes to the Terms of Use, the User must cease using our website and/or services immediately.

Indemnification
You agree to indemnify, defend and hold harmless the Company, its affiliated companies, employees, agents, and any third-party information providers from and against all claims, losses, expenses, damages and costs (including, but not limited to, direct, incidental, consequential, exemplary and indirect damages), and reasonable attorneys' fees, resulting from or arising out of your use, misuse, or inability to use the Services, or any violation by you of these Terms. 
Applicable Law
These Terms of Use shall be interpreted and governed by the laws currently in force in the Federal Republic of Nigeria.
Legal disputes
We shall make an effort to settle all disputes amicably. Any dispute arising out of this Terms of Use, which cannot be settled, by mutual agreement/negotiation within 1 (one) month shall be referred to arbitration by a single arbitrator at the Lagos Multi-Door Courthouse (“LMDC”) and governed by the Arbitration and Conciliation Act, Cap A10, Laws of the Federal Republic of Nigeria. The arbitrator shall be appointed by both of us (we and you), where both of us are unable to agree on the choice of an arbitrator, the choice of arbitration shall be referred to the LMDC. The findings of the arbitrator and subsequent award shall be binding on both of us. Each of us shall bear our respective costs in connection with the Arbitration. The venue for the arbitration shall be Lagos, Nigeria.
Severability
If any portion of these Terms of Use is held by any court or tribunal to be invalid or unenforceable, either in whole or in part, then that part shall be severed from these Terms of Use and shall not affect the validity or enforceability of any other part in this Terms of Use.
Assignment
This agreement is a personal agreement between COMPANY and you. As a result, you are not allowed to assign your rights under this agreement to a third party. On the other hand, we can and will only transfer any of your and our rights or obligations under the agreement if we reasonably think that this won't have a significant negative effect on your rights under these Terms or if we need to do so to keep to any legal or regulatory requirement. 
Waiver
Our failure or delay in enforcing any of our rights under these terms, if you break the agreement does not amount to a waiver and will not prevent us from enforcing those or any other rights at a later date within the period stipulated by applicable law.
Privacy Policy
You agree to the COMPANY’s Privacy Policy, which explains how we collect, use and protect the personal information you provide to us. 
CONTACT US
If you have any questions about these Terms, please contact us at $APP_PARTNER_SUPPORT_EMAIL.
"""),
          ],
        ),
      )),
    );
  }
}
