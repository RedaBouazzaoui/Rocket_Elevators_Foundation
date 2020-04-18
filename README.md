Week# 10: Security Assessment
1. A2:2017 - Broken Authentication
What is it?
Most of the current websites require users and password to login access to their
accounts. When a visitor enters in a website and sign in, the site will generate a unique
session ID. It's important to encrypt this information because it's possible for someone
to intercept a visitor session ID or credentials to do some attacks. Also, the weakness of
the password (123456, password, Password1...) may result in a simple sign up with an
admin account with for example the brute-force attack. Finally, another problem may
occur when the session timeout isn’t set properly, if the user didn't select the ''logout''
and only close the tab, an attacker uses the browser after some time and is still login.
What could happen if the vulnerability if not corrected?
The broken authentication could result in an attacker impersonating a valid user. With
this information, the attackers gain access to account and need just one admin account
to compromise the system. On my system, with an admin account, you gain access to
the admin page. On the admin page, you can add, modify, and delete all the information
in the database. You gain also access to the intervention page where an attacker could
send false interventions to the employee through Zendesk. It may result in money
laundering, social security fraud and identity theft. 
What I have done to resolve the vulnerability?
• Use an SSL Certificat : SSL Encryption is used to prevent man-in-the-middle type
attacks on your site’s sessions, it is important to encrypt the data in transit using an SSL
certificate. As the name implies, an SSL (secure socket layer) is a digital certificate that
encrypts information sent between a web server and web browser In the code:
config.force_ssl = true
• Enforce Strong Password : Regarding brute force attacks, mentioned earlier in this
wiki, it’s a good practice to have password requirements for any and all registered users
on a site (this includes admin accounts, especially!). Strong passwords do not include
complete words, but rather are a mix of random letters (both uppercase and lowercase),
numbers, and symbols, so the password can’t be easily guessed. -I Added the gem
devise_zxcvbn. Password now need to be to the scores number 4 wich mean that the
estimated time to crack it is about 10^8 seconds. Now password need to have a symbol,
a capital letter and at least one number. ​config.min_password_score = 4​ 
-Also, i modified the length of the password to 8 characters
config.password_length = 8..128​ -To prevent the brute force attack, the maximu
attempts for an account is set to 20
config.maximum_attempts = 20
●Finally, the timeout for session without activity is set to 10 minutes
config.timeout_in = 10.minutes

2. A3:2017 - Sensitive Data Exposure
What is it?
Many web applications and APIs do not properly protect sensitive data, such as
financial, healthcare, customers name/phone/addres etc. Attackers may steal or modify
such weakly protected data to conduct credit card fraud, identity theft, or other crimes.
Sensitive data may be compromised without extra protection, such as encryption at rest
or in transit, and requires special precautions when exchanged with the browser.
What could happen if the vulnerability if not corrected?
The sensitive data exposure may result in a compromise of all data. For my website,
this data is about all the users, customers and employees information’s (name, phone
number, email, address etc).
What I have done to resolve the vulnerability?
• In devise, I change the secret_key_configuration used by rails for a new one (rails
secret) • Change the Zendesk url (in the controller) with an ENV variables in
application.yml • Change the Zendesk email (in the controller) with an ENV variables in
application.yml • Also, done previously in the applications.yml there are : sengrid, slack,
twilio, Watson, google_map and credential. • Forces all access to the application over
SSL (Secure Socket Layer / TLS (Transport Layer Security)) and use secured cookie
with the ​config.force_ssl
• In devise.rb, config_secret_key is now an ENV variables in application.yml -The
credential key is now in application.yml

3. A5:2017 – Broken access control
What is it?
Restrictions on what authenticated users can do are often not properly enforced.
Attackers can exploit these flaws to access unauthorized functionality and/or data, such
as access other users accounts, view sensitive files, modify other users’ data, change
access rights, etc
What could happen if the vulnerability if not corrected?
The impact is that the attackers acting as users or worst as administrator (in my case)
and use this privilege for creating, deleting, and updating record in the database. In my
website, the attacker could have access to all the informations about the customers,
users, employees, elevators… The page for example Interventions was accessible to all
with the rocketelevatorsjm/interventions. So, anybody can have access to the
information about the customers, battery, building…
What I have done to resolve the vulnerability?
• I blocked the access to the intervention’s page. If you are not an administrator, you
cannot have access to this page. • Also, I have checked, blazer and admin section are
still safe from the broken access control.

4. A7:2017 – Cross-Site Scripting (XSS)
What is it?
XSS flaws occurs whenever an application includes untrusted data in a new web page
without proper validation, escaping or updates an existing web page with user-supplied
data using a browser API that can create HTML or JavaScript. XSS allows attackers to
execute scripts in the victim’s browser which can hijack user sessions, deface web
sites, or redirect the user to malicious sites. 
What could happen if the vulnerability if not corrected?
The attacker can read anything vulnerable on the page, insert/remove content, steal
cookies/sessions, send requests on behalf of the victim. Also, the attacker can send
with the POST method a script like : ​<script> var xhr = new
XMLHttpRequest();xhr.open('POST','http://localhost:3001/Users/informations/xss
_s/',true); </script
For example, if the victim asks for all the elevators in the DB (GET method), the victim
browser will have the html <script>…</script> form the attackers. The script could send
the victim cookies and send it for example to ​http://evil.com/cookie={cookie}
What I have done to resolve the vulnerability?
• Forces all access to the application over SSL (Secure Socket Layer / TLS (Transport 
Layer Security)) and use secured cookie in the production.rb with ​config.force_ssl 
• Prevents requests who are not from the controllers: ​protect_from_forgery with: 
:exception 
5. A9:2017 – Using Components with
Known Vulnerabilities
What is it?
Components, such as libraries, frameworks, and other software modules, run with the 
same privileges as the application. If a vulnerable component is exploited, such an 
attack can facilitate serious data loss or server takeover. Applications and APIs using 
components with known vulnerabilities may undermine application defenses and enable 
various attacks and impacts. 
What could happen if the vulnerability if not corrected? 
While some known vulnerabilities lead to only minor impacts, some of the largest 
breaches to date have relied on exploiting known vulnerabilities in components. 
Depending on the assets you are protecting, perhaps this risk should be at the top of 
the list. 
What I have done to resolve the vulnerability? 
●Bundle update so all my gems are now update so the risk decreases 
●Previously downgrade ruby to 2.6.3 because 2.7.0 could cause a lot of problems 
with some API 
●Check that all the gems are used and remove them otherwise 
●I could pay with FireCloud for a web application firewall (WAF) 
●In the head of each html_page <%= csrf_meta_tags %>

6. A10:2017 – Insufficient Logging &Monitoring
What is it?
In professional environments, logging for traceability of events is important. Insufficient 
logging and monitoring allow attackers to further attack systems. The insufficient logging 
compromises are sometimes not detected or detected much too late. On average, it is
estimated that its take over 7 months for a hacker attack to be detected.
What could happen if the vulnerability if not corrected?
Most successful attacks start with vulnerability probing. Allowing such probes to
continue can raise the likelihood of successful exploit to nearly 100%. Again, theses
attacks could lead to the steal of data or damage on the database. When you see the
damage, it is already too late.
What I have done to resolve the vulnerability?
●Use the log files in production
●Modify the logs that are created to be used in a format that can be easily use
●Retain the logs for a period of time that allows the team to do forensic analysis
●Evaluate what is the normal traffic on the Rocket Elevator web site
●What for the multipled failed login attemps
●Keep an eye on the API
Annex :
I have done the static analysis security vulnerability scanner with Brakeman gem : ==
Overview == Controllers: 6 Models: 15 Templates: 43 Errors: 0 Security
Warnings: 0
Also done the OWASP ZAP 2.9.0 (Zed attack proxy) and the result is no red or orange
flags in the report.

 
    
## Back Office Admin Logins
- Reda Bouazzaoui  email : reda.bouazzaoui10@gmail.com ,  passeword : 123456

- Mathieu Houde | coach | mathieu.houde@codeboxx.biz | password: 123456
- Patrick Thibault | coach | tiboclan@gmail.com | password: 123456
- Philippe Motillon | coach | philippe.motillon@keyrus.ca | password: 123456



## Configuration
  - Ruby version : 2.6.5  
  - Rails version : 5.2.4.1
  - Gem version : 3.1.2
  - Bundler version : 1.17.3

## List of required Gems
  actioncable (6.0.2.1, 5.2.4.1)  
  actionmailbox (6.0.2.1)  
  actionmailer (6.0.2.1, 5.2.4.1)  
  actionpack (6.0.2.1, 5.2.4.1)  
  actiontext (6.0.2.1)  
  actionview (6.0.2.1, 5.2.4.1)  
  activeadmin (2.6.1)  
  activejob (6.0.2.1, 5.2.4.1)  
  activemodel (6.0.2.1, 5.2.4.1)  
  activerecord (6.0.2.1, 5.2.4.1)  
  activestorage (6.0.2.1, 5.2.4.1)  
  activesupport (6.0.2.1, 5.2.4.1)  
  addressable (2.7.0)  
  airbrussh (1.4.0)  
  arbre (1.2.1)  
  archive-zip (0.12.0)  
  arel (9.0.0)  
  autoprefixer-rails (9.7.4)  
  bcrypt (3.1.13)  
  bigdecimal (default: 1.4.1)  
  bindex (0.8.1)  
  bootsnap (1.4.6)  
  bootstrap (4.4.1)  
  builder (3.2.4)  
  bundler (2.1.4, default: 2.1.2, 1.17.3)  
  bundler-unload (1.0.2)  
  byebug (11.1.1)  
  capistrano (3.12.0)  
  capistrano-bundler (1.6.0)  
  capistrano-rails (1.4.0)  
  capistrano3-puma (3.1.1)  
  capybara (3.31.0)  
  childprocess (3.0.0)  
  chromedriver-helper (2.1.1)  
  chronic (0.10.2)  
  cmath (default: 1.0.0)  
  coffee-rails (4.2.2)  
  coffee-script (2.4.1)  
  coffee-script-source (1.12.2)  
  concurrent-ruby (1.1.6)  
  crass (1.0.6)  
  csv (default: 3.0.9)  
  date (3.0.0, default: 2.0.0)  
  dbm (default: 1.0.0)  
  devise (4.7.1)  
  did_you_mean (1.3.0)  
  e2mmap (default: 0.1.0)  
  erubi (1.9.0)  
  etc (default: 1.0.1)  
  execjs (2.7.0)  
  executable-hooks (1.6.0)  
  faker (2.10.2)  
  fcntl (default: 1.0.0)  
  ffi (1.12.2)  
  fiddle (default: 1.0.0)  
  fileutils (default: 1.1.0)  
  font-awesome-rails (4.7.0.5)  
  font-awesome-sass (5.12.0)  
  formtastic (3.1.5)  
  formtastic_i18n (0.6.0)  
  forwardable (default: 1.2.0)  
  gem-wrappers (1.4.0)  
  globalid (0.4.2)  
  haml (5.1.2)  
  has_scope (0.7.2)  
  hirb (0.7.3)  
  i18n (1.8.2)  
  inherited_resources (1.11.0)  
  io-console (default: 0.4.7)  
  io-like (0.3.1)  
  ipaddr (default: 1.2.2)  
  irb (default: 1.0.0)  
  jbuilder (2.10.0)  
  jquery-rails (4.3.5)  
  json (default: 2.1.0)  
  kaminari (1.2.0)  
  kaminari-actionview (1.2.0)  
  kaminari-activerecord (1.2.0)  
  kaminari-core (1.2.0)  
  listen (3.1.5)  
  logger (default: 1.3.0)  
  loofah (2.4.0)  
  mail (2.7.1)  
  marcel (0.3.3)  
  matrix (default: 0.1.0)  
  method_source (0.9.2)  
  mimemagic (0.3.4)  
  mini_mime (1.0.2)  
  mini_portile2 (2.4.0)  
  minitest (5.14.0, 5.11.3)  
  mixitup-rails (3.3.1)  
  msgpack (1.3.3)  
  mutex_m (default: 0.1.0)  
  mysql2 (0.5.3)  
  net-scp (2.0.0)  
  net-ssh (5.2.0)  
  net-telnet (0.2.0)  
  nio4r (2.5.2)  
  nokogiri (1.10.9)  
  openssl (default: 2.1.2)  
  orm_adapter (0.5.0)  
  ostruct (default: 0.1.0)  
  owlcarousel-rails (1.1.3.3)  
  pg (1.2.2, 0.18.4)  
  polyamorous (2.3.2)  
  popper_js (1.16.0)  
  power_assert (1.1.3)  
  prime (default: 0.1.0)  
  psych (default: 3.1.0)  
  public_suffix (4.0.3)  
  puma (4.3.3, 3.12.4)  
  rack (2.2.2)  
  rack-proxy (0.6.5)  
  rack-test (1.1.0)  
  rails (6.0.2.1, 5.2.4.1)  
  rails-assets-datatables (1.10.19)  
  rails-assets-jquery (3.4.1)  
  rails-dom-testing (2.0.3)  
  rails-html-sanitizer (1.3.0)  
  railties (6.0.2.1, 5.2.4.1)  
  rake (13.0.1, 12.3.2)  
  ransack (2.3.2)  
  rb-fsevent (0.10.3)  
  rb-inotify (0.10.1)  
  rdoc (default: 6.1.2)  
  regexp_parser (1.7.0)  
  responders (3.0.0)  
  rexml (default: 3.1.9)  
  rss (default: 0.2.7)  
  ruby_dep (1.5.0)  
  rubygems-bundler (1.4.5)  
  rubygems-update (3.1.2)  
  rubyzip (2.2.0)  
  rvm (1.11.3.9)  
  rvm1-capistrano3 (1.4.0)  
  sass (3.7.4)  
  sass-listen (4.0.0)  
  sass-rails (6.0.0, 5.1.0)  
  sassc (2.2.1)  
  sassc-rails (2.1.2)  
  scanf (default: 1.0.0)  
  sdbm (default: 1.0.0)  
  selenium-webdriver (3.142.7)  
  shell (default: 0.7)  
  spring (2.1.0)  
  spring-watcher-listen (2.0.1)  
  sprockets (4.0.0, 3.7.2)  
  sprockets-rails (3.2.1)  
  sshkit (1.21.0)  
  stringio (default: 0.0.2)  
  strscan (default: 1.0.0)  
  sync (default: 0.5.0)  
  temple (0.8.2)  
  test-unit (3.2.9)  
  thor (1.0.1)  
  thread_safe (0.3.6)  
  thwait (default: 0.1.0)  
  tilt (2.0.10)  
  tracer (default: 0.1.0)  
  turbolinks (5.2.1)  
  turbolinks-source (5.2.0)  
  tzinfo (1.2.6)  
  uglifier (4.2.0)  
  warden (1.2.8)  
  web-console (4.0.1, 3.7.0)  
  webdrivers (4.2.0)  
  webpacker (4.2.2)  
  webrick (default: 1.4.2)  
  websocket-driver (0.7.1)  
  websocket-extensions (0.1.4)  
  whenever (1.0.0)  
  xmlrpc (0.3.0)  
  xpath (3.2.0)  
  zeitwerk (2.3.0)  
  zlib (default: 1.0.0)  
  
