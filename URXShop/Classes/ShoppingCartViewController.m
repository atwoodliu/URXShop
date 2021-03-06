//
//  ShoppingCartViewController.m
//  URXShop
//
//  Created by David Lee on 10/17/13.
//  Copyright (c) 2013 URX Inc. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ProductCell.h"

#define ROW_HEIGHT 173.0f
#define SIZE_BUTTON_TAG_OFFSET 1000

@interface ShoppingCartViewController ()

@end

@implementation ShoppingCartViewController

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        // The className to query on
		self.className = @"Item";
        
		// Whether the built-in pull-to-refresh is enabled
		self.pullToRefreshEnabled = YES;
        
		// Whether the built-in pagination is enabled
		self.paginationEnabled = YES;
        
		// The number of objects to show per page
		self.objectsPerPage = 1;
        
        // Set the tabBarItem icon:
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Catalog" image:[UIImage imageNamed:@"shoppingCart_icon.png"] tag:1];
        self.tabBarItem = tabBarItem;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;

    [self.tableView registerClass:[ProductCell class] forCellReuseIdentifier:@"ItemCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - PFQueryTableViewController datasource methods

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    // This method is called every time objects are loaded from Parse via the PFQuery
}

- (void)objectsWillLoad {
    [super objectsWillLoad];
    // This method is called before a PFQuery is fired to get more objects
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *CellIdentifier = @"ItemCell";
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[ProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    PFObject *product = self.objects[indexPath.row];
    [cell configureProduct:product];
    
    return cell;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.objects count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ROW_HEIGHT;
}

@end
