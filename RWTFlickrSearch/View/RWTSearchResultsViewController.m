//
//  Created by Colin Eberhardt on 23/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTSearchResultsViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CETableViewBindingHelper.h"


@interface RWTSearchResultsViewController ()<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *searchResultsTable;

@property (strong, nonatomic) RWTSearchResultsViewModel *viewModel;

@property (strong, nonatomic) CETableViewBindingHelper *bindingHelper;


@end

@implementation RWTSearchResultsViewController

- (instancetype)initWithViewModel:(RWTSearchResultsViewModel *)viewModel {
    if (self = [super init]) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.searchResultsTable registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    self.searchResultsTable.dataSource = self;
    [self bindViewModel];
}

- (void)bindViewModel
{
    self.title = self.viewModel.title;

    UINib *nib = [UINib nibWithNibName:@"RWTSearchResultsTableViewCell" bundle:nil];
    
    self.bindingHelper =
    [CETableViewBindingHelper bindingHelperForTableView:self.searchResultsTable
                                           sourceSignal:RACObserve(self.viewModel, searchResults)
                                       selectionCommand:nil
                                           templateCell:nib];
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.searchResults.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 44;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [self.viewModel.searchResults[indexPath.row] title];
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}



@end
