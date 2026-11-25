# Smart Contractor API ইন্টিগ্রেশন রোডম্যাপ

স্ক্রিন অডিটের ভিত্তিতে কাজটি ৬ ধাপে ভাগ করা হয়েছে। প্রথম মাইলস্টোন হলো নতুন ক্লায়েন্ট থেকে কাজ, মালামালের তালিকা ও ডাউনলোডযোগ্য PDF পর্যন্ত পুরো প্রবাহ সম্পন্ন করা। নিচের চেকবক্সগুলো পরবর্তী সেশনে অগ্রগতি ধরে রাখার জন্য।

## বাস্তবায়নের ৬ ধাপ

- [ ] **১. রেকর্ড, রুট ও ফর্ম স্টেট**  
  Business, Client, Job, Worker ও Payment-এর ID এবং সম্পর্ক স্থির করুন। Details, Edit, Payment ও PDF-এ typed arguments বা record ID পাঠান। Job Details ও Worker Details-এ নির্বাচিত রেকর্ড পড়ার সমস্যা আগে ঠিক করুন। নতুন ফর্মের draft আলাদা রাখুন।  
  **যাচাই** — দুইটি কাজ ও কর্মী খুললে তাদের নিজস্ব তথ্য আসে। নতুন ফর্মে আগের ইনপুট থাকে না।

- [ ] **২. ক্লায়েন্ট, কাজ, মালামাল ও PDF**  
  Repository interface ও in-memory implementation দিয়ে Client ও Job create/edit যুক্ত করুন। এরপর template/direct list, item add/edit/delete, merge rule, PDF settings ও export সংযুক্ত করুন। খালি তালিকার নমুনা fallback সরান এবং PDF-এ সেভ করা তালিকার তথ্য ব্যবহার করুন।  
  **যাচাই** — নতুন ক্লায়েন্ট ও কাজের জন্য তালিকা বদলালে preview, download ও share-এ একই PDF আসে। ফোনের Downloads বা Files থেকে PDF খুলে দেখুন।

- [ ] **৩. হাজিরা, মজুরি ও পেমেন্ট**  
  কর্মী ও তারিখ ধরে হাজিরা এবং কর্মী ও মাস ধরে বেতন সেভ করুন। Full/half-day rate, split wage, ক্লায়েন্ট বকেয়া, অগ্রিম, বাড়তি বিল ও খরচের হিসাব নির্ধারণ করুন। বাংলা ও ইংরেজি অঙ্ক গ্রহণ করুন। সেভে validation ও duplicate submission guard দিন।  
  **যাচাই** — ৳৮০০ মজুরি ৳৫০০ + ৳৩০০ হিসেবে সেভ হয়। ৳১০,০০০ বিলে ৳৪,০০০ পেলে ৳৬,০০০ বকেয়া থাকে। ভুল ভাগ ও দ্বিতীয়বার একই পেমেন্ট সেভ আটকায়।

- [ ] **৪. বিল, রসিদ, হিসাবের PDF ও রিপোর্ট**  
  Final Bill, Payment Receipt ও Worker Ledger-এ shared PDF service ব্যবহার করুন। PDF history-তে নথির ID এবং ফাইল বা অপরিবর্তনীয় snapshot-এর রেফারেন্স দিন। Home ও মাসিক রিপোর্ট সেভ করা রেকর্ড থেকে হিসাব করুন।  
  **যাচাই** — নতুন পেমেন্ট সংশ্লিষ্ট হিসাব বদলায়। মাস বদলালে রিপোর্টের রেকর্ড বদলায়। পুরোনো রসিদ খুললে তার অঙ্ক ও তারিখ একই থাকে।

- [ ] **৫. Auth ও API contract**  
  Mock session দিয়ে login, registration, business setup, OTP, session expiry ও logout যাচাই করুন। Backend-এর সঙ্গে ID, তারিখ, টাকা, status, pagination, field errors ও payment retry-এর contract ঠিক করুন। Dio logging থেকে পাসওয়ার্ড, OTP ও সংবেদনশীল তথ্য বাদ দিন।  
  **যাচাই** — Contract দিয়ে mock response তৈরি করা যায়। Loading, empty, validation error, session expiry ও retry অবস্থায় স্ক্রিনের আচরণ নির্ধারিত।

- [ ] **৬. টেস্ট ও পর্যায়ক্রমে API ইন্টিগ্রেশন**  
  স্টার্টার counter test বদলে মূল প্রবাহের smoke test দিন। Wage, balance, duplicate payment ও DTO mapping-এর unit test যোগ করুন। API সংযোগের ক্রম **Auth ও Business → Clients, Workers ও Jobs → Materials ও Attendance → Payments, PDF History ও Reports**।  
  **যাচাই** — একই UI ও কন্ট্রোলার fake এবং API repository দিয়ে চালানো যায়। মূল প্রবাহগুলো সঠিক রেকর্ড ও হিসাব দেখায়।

## প্রথম কাজ

ধাপ ১ থেকে শুরু করুন। Job ও Worker Details-এ ID প্রবাহ ঠিক করে Client ও Job ফর্মের save → list → details প্রবাহ চালু করুন। তারপর মালামালের add/edit/delete ও PDF দিয়ে প্রথম মাইলস্টোন শেষ করুন। প্রথম রিলিজে প্রয়োজন না হলে bulk payment, template copy ও পূর্ণাঙ্গ রিপোর্টের অসম্পূর্ণ অ্যাকশন পরে চালু করুন।
